package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ItemCriterionOperator extends Object implements IDataCenter
   {
      
      public function ItemCriterionOperator(pStringOperator:String) {
         super();
         this._operator = pStringOperator;
      }
      
      public static const SUPERIOR:String = ">";
      
      public static const INFERIOR:String = "<";
      
      public static const EQUAL:String = "=";
      
      public static const DIFFERENT:String = "!";
      
      public static const OPERATORS_LIST:Array;
      
      private var _operator:String;
      
      public function get text() : String {
         return this._operator;
      }
      
      public function compare(pLeftMember:int, pRightMember:int) : Boolean {
         switch(this._operator)
         {
            case SUPERIOR:
               if(pLeftMember > pRightMember)
               {
                  return true;
               }
               break;
            case INFERIOR:
               if(pLeftMember < pRightMember)
               {
                  return true;
               }
               break;
            case EQUAL:
               if(pLeftMember == pRightMember)
               {
                  return true;
               }
               break;
            case DIFFERENT:
               if(pLeftMember != pRightMember)
               {
                  return true;
               }
               break;
         }
         return false;
      }
   }
}
