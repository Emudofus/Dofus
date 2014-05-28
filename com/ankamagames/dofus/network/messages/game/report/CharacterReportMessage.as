package com.ankamagames.dofus.network.messages.game.report
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterReportMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterReportMessage() {
         super();
      }
      
      public static const protocolId:uint = 6079;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reportedId:uint = 0;
      
      public var reason:uint = 0;
      
      override public function getMessageId() : uint {
         return 6079;
      }
      
      public function initCharacterReportMessage(reportedId:uint = 0, reason:uint = 0) : CharacterReportMessage {
         this.reportedId = reportedId;
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reportedId = 0;
         this.reason = 0;
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
         this.serializeAs_CharacterReportMessage(output);
      }
      
      public function serializeAs_CharacterReportMessage(output:IDataOutput) : void {
         if((this.reportedId < 0) || (this.reportedId > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.reportedId + ") on element reportedId.");
         }
         else
         {
            output.writeUnsignedInt(this.reportedId);
            if(this.reason < 0)
            {
               throw new Error("Forbidden value (" + this.reason + ") on element reason.");
            }
            else
            {
               output.writeByte(this.reason);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterReportMessage(input);
      }
      
      public function deserializeAs_CharacterReportMessage(input:IDataInput) : void {
         this.reportedId = input.readUnsignedInt();
         if((this.reportedId < 0) || (this.reportedId > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.reportedId + ") on element of CharacterReportMessage.reportedId.");
         }
         else
         {
            this.reason = input.readByte();
            if(this.reason < 0)
            {
               throw new Error("Forbidden value (" + this.reason + ") on element of CharacterReportMessage.reason.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
