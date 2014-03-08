package com.ankamagames.dofus.network.messages.game.context.fight
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameFightOptionStateUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameFightOptionStateUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 5927;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:uint = 0;
      
      public var teamId:uint = 2;
      
      public var option:uint = 3;
      
      public var state:Boolean = false;
      
      override public function getMessageId() : uint {
         return 5927;
      }
      
      public function initGameFightOptionStateUpdateMessage(param1:uint=0, param2:uint=2, param3:uint=3, param4:Boolean=false) : GameFightOptionStateUpdateMessage {
         this.fightId = param1;
         this.teamId = param2;
         this.option = param3;
         this.state = param4;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.teamId = 2;
         this.option = 3;
         this.state = false;
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
         this.serializeAs_GameFightOptionStateUpdateMessage(param1);
      }
      
      public function serializeAs_GameFightOptionStateUpdateMessage(param1:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            param1.writeShort(this.fightId);
            param1.writeByte(this.teamId);
            param1.writeByte(this.option);
            param1.writeBoolean(this.state);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightOptionStateUpdateMessage(param1);
      }
      
      public function deserializeAs_GameFightOptionStateUpdateMessage(param1:IDataInput) : void {
         this.fightId = param1.readShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightOptionStateUpdateMessage.fightId.");
         }
         else
         {
            this.teamId = param1.readByte();
            if(this.teamId < 0)
            {
               throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightOptionStateUpdateMessage.teamId.");
            }
            else
            {
               this.option = param1.readByte();
               if(this.option < 0)
               {
                  throw new Error("Forbidden value (" + this.option + ") on element of GameFightOptionStateUpdateMessage.option.");
               }
               else
               {
                  this.state = param1.readBoolean();
                  return;
               }
            }
         }
      }
   }
}
