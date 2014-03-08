package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PrismFightDefenderAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightDefenderAddMessage() {
         this.defender = new CharacterMinimalPlusLookInformations();
         super();
      }
      
      public static const protocolId:uint = 5895;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var fightId:Number = 0;
      
      public var defender:CharacterMinimalPlusLookInformations;
      
      override public function getMessageId() : uint {
         return 5895;
      }
      
      public function initPrismFightDefenderAddMessage(param1:uint=0, param2:Number=0, param3:CharacterMinimalPlusLookInformations=null) : PrismFightDefenderAddMessage {
         this.subAreaId = param1;
         this.fightId = param2;
         this.defender = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.fightId = 0;
         this.defender = new CharacterMinimalPlusLookInformations();
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
         this.serializeAs_PrismFightDefenderAddMessage(param1);
      }
      
      public function serializeAs_PrismFightDefenderAddMessage(param1:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeShort(this.subAreaId);
            param1.writeDouble(this.fightId);
            param1.writeShort(this.defender.getTypeId());
            this.defender.serialize(param1);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismFightDefenderAddMessage(param1);
      }
      
      public function deserializeAs_PrismFightDefenderAddMessage(param1:IDataInput) : void {
         this.subAreaId = param1.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightDefenderAddMessage.subAreaId.");
         }
         else
         {
            this.fightId = param1.readDouble();
            _loc2_ = param1.readUnsignedShort();
            this.defender = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_loc2_);
            this.defender.deserialize(param1);
            return;
         }
      }
   }
}
