package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class AlliancePartialListMessage extends AllianceListMessage implements INetworkMessage
   {
      
      public function AlliancePartialListMessage() {
         super();
      }
      
      public static const protocolId:uint = 6427;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6427;
      }
      
      public function initAlliancePartialListMessage(alliances:Vector.<AllianceFactSheetInformations>=null) : AlliancePartialListMessage {
         super.initAllianceListMessage(alliances);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_AlliancePartialListMessage(output);
      }
      
      public function serializeAs_AlliancePartialListMessage(output:IDataOutput) : void {
         super.serializeAs_AllianceListMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlliancePartialListMessage(input);
      }
      
      public function deserializeAs_AlliancePartialListMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
