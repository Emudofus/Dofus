package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AllianceCreationResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function AllianceCreationResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 6391;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var result:uint = 0;
      
      override public function getMessageId() : uint {
         return 6391;
      }
      
      public function initAllianceCreationResultMessage(param1:uint=0) : AllianceCreationResultMessage {
         this.result = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.result = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_AllianceCreationResultMessage(param1);
      }
      
      public function serializeAs_AllianceCreationResultMessage(param1:IDataOutput) : void {
         param1.writeByte(this.result);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_AllianceCreationResultMessage(param1);
      }
      
      public function deserializeAs_AllianceCreationResultMessage(param1:IDataInput) : void {
         this.result = param1.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of AllianceCreationResultMessage.result.");
         }
         else
         {
            return;
         }
      }
   }
}
