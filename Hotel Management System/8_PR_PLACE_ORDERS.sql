/* Procedure structure for procedure `PR_PLACE_ORDERS` */

/*!50003 DROP PROCEDURE IF EXISTS  `PR_PLACE_ORDERS` */;

DELIMITER $$

CREATE PROCEDURE `PR_PLACE_ORDERS`(in seatSno varchar(10),IN itemList MEDIUMTEXT,IN quantityList MEDIUMTEXT)
BEGIN
          DECLARE nextItem TEXT DEFAULT NULL ;
          DECLARE nextQuantity TEXT DEFAULT NULL;
          DECLARE nextQuantityLength INT DEFAULT NULL;
          declare totItem int;
          declare totQty int;
          DECLARE nextItemLength INT DEFAULT NULL;
          DECLARE nextItemValue TEXT DEFAULT NULL;
          DECLARE nextQuantityValue TEXT DEFAULT NULL;
          IF EXISTS(SELECT id FROM `hotel_seat` WHERE seat_no=seatSno) THEN  
          if (select status from hotel_seat where seat_no=seatSno) then
          select "Seat Is taken Please wait";
          else
          SELECT LENGTH(itemList) - LENGTH(REPLACE(itemList, ',', ''))+1 into totItem;
          SELECT LENGTH(quantityList) - LENGTH(REPLACE(quantityList, ',', ''))+1 INTO totQty;
          
          IF totItem=totQty then
		  start Transaction;
		  set autocommit=0;
		  Update hotel_seat set status=1 where seat_no=seatSno;
		 iterator :
		 LOOP    
		    IF LENGTH(TRIM(itemList)) = 0 OR itemList IS NULL THEN
		      LEAVE iterator;
		      END IF;
			 SET nextItem = SUBSTRING_INDEX(itemList,',',1);
			 SET nextQuantity=SUBSTRING_INDEX(quantityList,',',1);
			 SET nextItemLength = LENGTH(nextItem);
			 SET nextQuantityLength = LENGTH(nextQuantity);
			 SET nextItemValue = TRIM(nextItem);
			 SET nextQuantityValue= TRIM(nextQuantity);   
			 
			 call PR_PLACE_ORDER(seatSno,nextItem,nextQuantity,@out);
			
			 SET itemList = INSERT(itemList,1,nextItemLength + 1,'');
			 SET quantityList = INSERT(quantityList,1,nextQuantityLength + 1,'');
			 
		   END LOOP;   
		   commit;
		   UPDATE hotel_seat SET STATUS=0 WHERE seat_no=seatSno;
		   else
		   select "Invalid Entry or enter equal items and qty";
		   end if;
	    end if;
            ELSE
            SELECT "Invalid Seat No";
            end if;
    END $$
DELIMITER ;
