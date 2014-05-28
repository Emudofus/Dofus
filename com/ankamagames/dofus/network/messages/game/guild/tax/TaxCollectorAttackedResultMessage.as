package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorBasicInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TaxCollectorAttackedResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorAttackedResultMessage() {
         this.basicInfos = new TaxCollectorBasicInformations();
         this.guild = new BasicGuildInformations();
         super();
      }
      
      public static const protocolId:uint = 5635;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var deadOrAlive:Boolean = false;
      
      public var basicInfos:TaxCollectorBasicInformations;
      
      public var guild:BasicGuildInformations;
      
      override public function getMessageId() : uint {
         return 5635;
      }
      
      public function initTaxCollectorAttackedResultMessage(deadOrAlive:Boolean = false, basicInfos:TaxCollectorBasicInformations = null, guild:BasicGuildInformations = null) : TaxCollectorAttackedResultMessage {
         this.deadOrAlive = deadOrAlive;
         this.basicInfos = basicInfos;
         this.guild = guild;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.deadOrAlive = false;
         this.basicInfos = new TaxCollectorBasicInformations();
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
         this.serializeAs_TaxCollectorAttackedResultMessage(output);
      }
      
      public function serializeAs_TaxCollectorAttackedResultMessage(output:IDataOutput) : void {
         output.writeBoolean(this.deadOrAlive);
         this.basicInfos.serializeAs_TaxCollectorBasicInformations(output);
         this.guild.serializeAs_BasicGuildInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TaxCollectorAttackedResultMessage(input);
      }
      
      public function deserializeAs_TaxCollectorAttackedResultMessage(input:IDataInput) : void {
         this.deadOrAlive = input.readBoolean();
         this.basicInfos = new TaxCollectorBasicInformations();
         this.basicInfos.deserialize(input);
         this.guild = new BasicGuildInformations();
         this.guild.deserialize(input);
      }
   }
}
