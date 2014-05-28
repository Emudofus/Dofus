package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TaxCollectorDialogQuestionBasicMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorDialogQuestionBasicMessage() {
         this.guildInfo = new BasicGuildInformations();
         super();
      }
      
      public static const protocolId:uint = 5619;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var guildInfo:BasicGuildInformations;
      
      override public function getMessageId() : uint {
         return 5619;
      }
      
      public function initTaxCollectorDialogQuestionBasicMessage(guildInfo:BasicGuildInformations = null) : TaxCollectorDialogQuestionBasicMessage {
         this.guildInfo = guildInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.guildInfo = new BasicGuildInformations();
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
         this.serializeAs_TaxCollectorDialogQuestionBasicMessage(output);
      }
      
      public function serializeAs_TaxCollectorDialogQuestionBasicMessage(output:IDataOutput) : void {
         this.guildInfo.serializeAs_BasicGuildInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorDialogQuestionBasicMessage(input);
      }
      
      public function deserializeAs_TaxCollectorDialogQuestionBasicMessage(input:IDataInput) : void {
         this.guildInfo = new BasicGuildInformations();
         this.guildInfo.deserialize(input);
      }
   }
}
