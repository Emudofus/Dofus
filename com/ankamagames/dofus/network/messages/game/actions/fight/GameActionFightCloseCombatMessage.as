package com.ankamagames.dofus.network.messages.game.actions.fight
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameActionFightCloseCombatMessage extends AbstractGameActionFightTargetedAbilityMessage implements INetworkMessage
   {
      
      public function GameActionFightCloseCombatMessage() {
         super();
      }
      
      public static const protocolId:uint = 6116;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var weaponGenericId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6116;
      }
      
      public function initGameActionFightCloseCombatMessage(param1:uint=0, param2:int=0, param3:int=0, param4:int=0, param5:uint=1, param6:Boolean=false, param7:uint=0) : GameActionFightCloseCombatMessage {
         super.initAbstractGameActionFightTargetedAbilityMessage(param1,param2,param3,param4,param5,param6);
         this.weaponGenericId = param7;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.weaponGenericId = 0;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameActionFightCloseCombatMessage(param1);
      }
      
      public function serializeAs_GameActionFightCloseCombatMessage(param1:IDataOutput) : void {
         super.serializeAs_AbstractGameActionFightTargetedAbilityMessage(param1);
         if(this.weaponGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.weaponGenericId + ") on element weaponGenericId.");
         }
         else
         {
            param1.writeInt(this.weaponGenericId);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameActionFightCloseCombatMessage(param1);
      }
      
      public function deserializeAs_GameActionFightCloseCombatMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.weaponGenericId = param1.readInt();
         if(this.weaponGenericId < 0)
         {
            throw new Error("Forbidden value (" + this.weaponGenericId + ") on element of GameActionFightCloseCombatMessage.weaponGenericId.");
         }
         else
         {
            return;
         }
      }
   }
}
