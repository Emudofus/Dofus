package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ItemCriterionOperator extends Object implements IDataCenter
   {
      
      public function ItemCriterionOperator(param1:String) {
         super();
         this._operator = param1;
      }
      
      public static const SUPERIOR:String = ">";
      
      public static const INFERIOR:String = "<";
      
      public static const EQUAL:String = "=";
      
      public static const DIFFERENT:String = "!";
      
      public static const OPERATORS_LIST:Array = [SUPERIOR,INFERIOR,EQUAL,DIFFERENT,"#","~","s","S","e","E","v","i","X","/"];
      
      private var _operator:String;
      
      public function get text() : String {
         return this._operator;
      }
      
      public function compare(param1:int, param2:int) : Boolean {
         switch(this._operator)
         {
            case SUPERIOR:
               if(param1 > param2)
               {
                  return true;
               }
               break;
            case INFERIOR:
               if(param1 < param2)
               {
                  return true;
               }
               break;
            case EQUAL:
               if(param1 == param2)
               {
                  return true;
               }
               break;
            case DIFFERENT:
               if(param1 != param2)
               {
                  return true;
               }
               break;
         }
         return false;
      }
   }
}
