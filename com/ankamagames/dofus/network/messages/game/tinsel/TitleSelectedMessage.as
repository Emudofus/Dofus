package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TitleSelectedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TitleSelectedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6366;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var titleId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6366;
      }
      
      public function initTitleSelectedMessage(titleId:uint=0) : TitleSelectedMessage {
         this.titleId = titleId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.titleId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_TitleSelectedMessage(output);
      }
      
      public function serializeAs_TitleSelectedMessage(output:IDataOutput) : void {
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
         }
         else
         {
            output.writeShort(this.titleId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TitleSelectedMessage(input);
      }
      
      public function deserializeAs_TitleSelectedMessage(input:IDataInput) : void {
         this.titleId = input.readShort();
         if(this.titleId < 0)
         {
            throw new Error("Forbidden value (" + this.titleId + ") on element of TitleSelectedMessage.titleId.");
         }
         else
         {
            return;
         }
      }
   }
}
