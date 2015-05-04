package com.ankamagames.dofus.misc.utils.mapeditor
{
   import flash.utils.ByteArray;
   import flash.utils.IDataOutput;
   
   public class MapEditorMessage extends Object
   {
      
      public function MapEditorMessage(param1:uint)
      {
         super();
         this.type = param1;
      }
      
      public static const MESSAGE_TYPE_HELLO:uint = 1;
      
      public static const MESSAGE_TYPE_ELE:uint = 10;
      
      public static const MESSAGE_TYPE_DLM:uint = 20;
      
      public static const MESSAGE_TYPE_NPC:uint = 30;
      
      public var type:uint;
      
      public var data:ByteArray;
      
      public function serialize(param1:IDataOutput) : void
      {
         if(!this.data)
         {
            param1.writeInt(4);
            param1.writeInt(this.type);
         }
         else
         {
            param1.writeInt(4 + this.data.length);
            param1.writeInt(this.type);
            this.data.position = 0;
            param1.writeBytes(this.data);
         }
      }
   }
}
