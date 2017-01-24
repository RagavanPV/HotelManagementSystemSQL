# HotelManagementSystemSQL

This SQL project is based on Hotel Food Ordering System

# Features
* Place Order
* Cancel Order
* Pay Bills
* View Stocks
* Menu Card

# Place Order
  call PR_PLACE_ORDER(seatName,ItemName,qty,@out);
  
  call PR_PLACE_ORDERS(seatName,'Item List','qty List');
  
# Cancel Order
  call PR_CANCEL_ORDER(seatName,itemName,qty,@out);
 
# Pay Bills
   call PR_PAY_BILLS(orderNo,@out);
   
# View Stocks
   select * from VW_VIEW_STOCKS;

