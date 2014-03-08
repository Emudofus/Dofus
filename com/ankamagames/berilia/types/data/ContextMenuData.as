package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ContextMenuData extends Object implements IDataCenter
   {
      
      public function ContextMenuData(data:*, makerName:String, content:Array) {
         var entry:* = undefined;
         super();
         this.data = data;
         this.makerName = makerName;
         this.content = new UnsecureArray();
         for each (entry in content)
         {
            this.content.push(entry);
         }
      }
      
      public var data;
      
      public var makerName:String;
      
      public var content:UnsecureArray;
   }
}
