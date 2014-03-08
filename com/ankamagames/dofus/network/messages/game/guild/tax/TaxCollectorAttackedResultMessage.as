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
      
      public function initTaxCollectorAttackedResultMessage(param1:Boolean=false, param2:TaxCollectorBasicInformations=null, param3:BasicGuildInformations=null) : TaxCollectorAttackedResultMessage {
         this.deadOrAlive = param1;
         this.basicInfos = param2;
         this.guild = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.deadOrAlive = false;
         this.basicInfos = new TaxCollectorBasicInformations();
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
         this.serializeAs_TaxCollectorAttackedResultMessage(param1);
      }
      
      public function serializeAs_TaxCollectorAttackedResultMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.deadOrAlive);
         this.basicInfos.serializeAs_TaxCollectorBasicInformations(param1);
         this.guild.serializeAs_BasicGuildInformations(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TaxCollectorAttackedResultMessage(param1);
      }
      
      public function deserializeAs_TaxCollectorAttackedResultMessage(param1:IDataInput) : void {
         this.deadOrAlive = param1.readBoolean();
         this.basicInfos = new TaxCollectorBasicInformations();
         this.basicInfos.deserialize(param1);
         this.guild = new BasicGuildInformations();
         this.guild.deserialize(param1);
      }
   }
}
