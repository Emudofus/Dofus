package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ContextMenuData extends Object implements IDataCenter
   {
      
      public function ContextMenuData(param1:*, param2:String, param3:Array) {
         var _loc4_:* = undefined;
         super();
         this.data = param1;
         this.makerName = param2;
         this.content = new UnsecureArray();
         for each (_loc4_ in param3)
         {
            this.content.push(_loc4_);
         }
      }
      
      public var data;
      
      public var makerName:String;
      
      public var content:UnsecureArray;
   }
}
