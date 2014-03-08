package com.ankamagames.dofus.network.messages.game.context.roleplay.delay
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayDelayedObjectUseMessage extends GameRolePlayDelayedActionMessage implements INetworkMessage
   {
      
      public function GameRolePlayDelayedObjectUseMessage() {
         super();
      }
      
      public static const protocolId:uint = 6425;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var objectGID:uint = 0;
      
      override public function getMessageId() : uint {
         return 6425;
      }
      
      public function initGameRolePlayDelayedObjectUseMessage(param1:int=0, param2:uint=0, param3:Number=0, param4:uint=0) : GameRolePlayDelayedObjectUseMessage {
         super.initGameRolePlayDelayedActionMessage(param1,param2,param3);
         this.objectGID = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.objectGID = 0;
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
         this.serializeAs_GameRolePlayDelayedObjectUseMessage(param1);
      }
      
      public function serializeAs_GameRolePlayDelayedObjectUseMessage(param1:IDataOutput) : void {
         super.serializeAs_GameRolePlayDelayedActionMessage(param1);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         else
         {
            param1.writeShort(this.objectGID);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayDelayedObjectUseMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayDelayedObjectUseMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.objectGID = param1.readShort();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of GameRolePlayDelayedObjectUseMessage.objectGID.");
         }
         else
         {
            return;
         }
      }
   }
}
