package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.guild.tax.TaxCollectorInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class TaxCollectorMovementAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TaxCollectorMovementAddMessage() {
         this.informations = new TaxCollectorInformations();
         super();
      }
      
      public static const protocolId:uint = 5917;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var informations:TaxCollectorInformations;
      
      override public function getMessageId() : uint {
         return 5917;
      }
      
      public function initTaxCollectorMovementAddMessage(param1:TaxCollectorInformations=null) : TaxCollectorMovementAddMessage {
         this.informations = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.informations = new TaxCollectorInformations();
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
         this.serializeAs_TaxCollectorMovementAddMessage(param1);
      }
      
      public function serializeAs_TaxCollectorMovementAddMessage(param1:IDataOutput) : void {
         param1.writeShort(this.informations.getTypeId());
         this.informations.serialize(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TaxCollectorMovementAddMessage(param1);
      }
      
      public function deserializeAs_TaxCollectorMovementAddMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readUnsignedShort();
         this.informations = ProtocolTypeManager.getInstance(TaxCollectorInformations,_loc2_);
         this.informations.deserialize(param1);
      }
   }
}
