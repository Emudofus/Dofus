package com.ankamagames.dofus.network.messages.game.context.roleplay.death
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameRolePlayPlayerLifeStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameRolePlayPlayerLifeStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 5996;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var state:uint = 0;
      
      override public function getMessageId() : uint {
         return 5996;
      }
      
      public function initGameRolePlayPlayerLifeStatusMessage(param1:uint=0) : GameRolePlayPlayerLifeStatusMessage {
         this.state = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.state = 0;
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
         this.serializeAs_GameRolePlayPlayerLifeStatusMessage(param1);
      }
      
      public function serializeAs_GameRolePlayPlayerLifeStatusMessage(param1:IDataOutput) : void {
         param1.writeByte(this.state);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameRolePlayPlayerLifeStatusMessage(param1);
      }
      
      public function deserializeAs_GameRolePlayPlayerLifeStatusMessage(param1:IDataInput) : void {
         this.state = param1.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of GameRolePlayPlayerLifeStatusMessage.state.");
         }
         else
         {
            return;
         }
      }
   }
}
