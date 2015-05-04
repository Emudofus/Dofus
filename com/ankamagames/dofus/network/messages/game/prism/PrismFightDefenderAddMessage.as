package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PrismFightDefenderAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function PrismFightDefenderAddMessage()
      {
         this.defender = new CharacterMinimalPlusLookInformations();
         super();
      }
      
      public static const protocolId:uint = 5895;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var subAreaId:uint = 0;
      
      public var fightId:uint = 0;
      
      public var defender:CharacterMinimalPlusLookInformations;
      
      override public function getMessageId() : uint
      {
         return 5895;
      }
      
      public function initPrismFightDefenderAddMessage(param1:uint = 0, param2:uint = 0, param3:CharacterMinimalPlusLookInformations = null) : PrismFightDefenderAddMessage
      {
         this.subAreaId = param1;
         this.fightId = param2;
         this.defender = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
         this.fightId = 0;
         this.defender = new CharacterMinimalPlusLookInformations();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PrismFightDefenderAddMessage(param1);
      }
      
      public function serializeAs_PrismFightDefenderAddMessage(param1:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            param1.writeVarShort(this.subAreaId);
            if(this.fightId < 0)
            {
               throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
            }
            else
            {
               param1.writeVarShort(this.fightId);
               param1.writeShort(this.defender.getTypeId());
               this.defender.serialize(param1);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightDefenderAddMessage(param1);
      }
      
      public function deserializeAs_PrismFightDefenderAddMessage(param1:ICustomDataInput) : void
      {
         this.subAreaId = param1.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightDefenderAddMessage.subAreaId.");
         }
         else
         {
            this.fightId = param1.readVarUhShort();
            if(this.fightId < 0)
            {
               throw new Error("Forbidden value (" + this.fightId + ") on element of PrismFightDefenderAddMessage.fightId.");
            }
            else
            {
               var _loc2_:uint = param1.readUnsignedShort();
               this.defender = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_loc2_);
               this.defender.deserialize(param1);
               return;
            }
         }
      }
   }
}
