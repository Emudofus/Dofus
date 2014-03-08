package com.ankamagames.dofus.console.debug.frames
{
   import com.ankamagames.jerakine.messages.Frame;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.filesystem.File;
   import flash.events.Event;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.filesystem.FileStream;
   import flash.filesystem.FileMode;
   
   public class ReccordNetworkPacketFrame extends Object implements Frame
   {
      
      public function ReccordNetworkPacketFrame() {
         super();
      }
      
      private var _buffer:ByteArray;
      
      private var _msgCount:uint;
      
      public function get reccordedMessageCount() : uint {
         return this._msgCount;
      }
      
      public function get priority() : int {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      public function pushed() : Boolean {
         this._buffer = new ByteArray();
         this._msgCount = 0;
         return true;
      }
      
      public function pulled() : Boolean {
         var _loc1_:File = null;
         this._msgCount = 0;
         if(this._buffer.length)
         {
            _loc1_ = File.desktopDirectory;
            _loc1_.addEventListener(Event.CANCEL,this.onFileSelectionCancel);
            _loc1_.addEventListener(Event.SELECT,this.onFileSelected);
            _loc1_.browseForSave("Save");
         }
         return true;
      }
      
      public function process(param1:Message) : Boolean {
         if(param1 is INetworkMessage)
         {
            INetworkMessage(param1).pack(this._buffer);
            this._msgCount++;
         }
         return false;
      }
      
      private function onFileSelected(param1:Event) : void {
         File(param1.target).removeEventListener(Event.CANCEL,this.onFileSelected);
         var _loc2_:FileStream = new FileStream();
         _loc2_.open(File(param1.target),FileMode.WRITE);
         _loc2_.writeBytes(this._buffer);
         _loc2_.close();
         this._buffer = null;
      }
      
      private function onFileSelectionCancel(param1:Event) : void {
         File(param1.target).removeEventListener(Event.CANCEL,this.onFileSelectionCancel);
         this._buffer = null;
      }
   }
}
