package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PrismFightAttackerAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightAttackerAddMessage() {
         this.attacker = new CharacterMinimalPlusLookInformations();
         super();
      }
      
      public static const protocolId:uint = 5893;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var fightId:Number = 0;
      
      public var attacker:CharacterMinimalPlusLookInformations;
      
      override public function getMessageId() : uint {
         return 5893;
      }
      
      public function initPrismFightAttackerAddMessage(param1:uint=0, param2:Number=0, param3:CharacterMinimalPlusLookInformations=null) : PrismFightAttackerAddMessage {
         this.subAreaId = param1;
         this.fightId = param2;
         this.attacker = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
         this.fightId = 0;
         this.attacker = new CharacterMinimalPlusLookInformations();
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
         this.serializeAs_PrismFightAttackerAddMessage(param1);
      }
      
      public function serializeAs_PrismFightAttackerAddMessage(param1:IDataOutput) : void {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeShort(this.subAreaId);
            param1.writeDouble(this.fightId);
            param1.writeShort(this.attacker.getTypeId());
            this.attacker.serialize(param1);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PrismFightAttackerAddMessage(param1);
      }
      
      public function deserializeAs_PrismFightAttackerAddMessage(param1:IDataInput) : void {
         this.subAreaId = param1.readShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightAttackerAddMessage.subAreaId.");
         }
         else
         {
            this.fightId = param1.readDouble();
            _loc2_ = param1.readUnsignedShort();
            this.attacker = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_loc2_);
            this.attacker.deserialize(param1);
            return;
         }
      }
   }
}
