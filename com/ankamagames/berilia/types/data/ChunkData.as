package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.types.Uri;
   
   public class ChunkData extends Object
   {
      
      public function ChunkData(param1:String, param2:Uri) {
         super();
         this.name = param1;
         this.uri = param2;
      }
      
      public var name:String;
      
      public var uri:Uri;
   }
}
