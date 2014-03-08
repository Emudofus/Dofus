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
      
      public function initGameFightOptionStateUpdateMessage(fightId:uint=0, teamId:uint=2, option:uint=3, state:Boolean=false) : GameFightOptionStateUpdateMessage {
         this.fightId = fightId;
         this.teamId = teamId;
         this.option = option;
         this.state = state;
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
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightOptionStateUpdateMessage(output);
      }
      
      public function serializeAs_GameFightOptionStateUpdateMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            output.writeShort(this.fightId);
            output.writeByte(this.teamId);
            output.writeByte(this.option);
            output.writeBoolean(this.state);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightOptionStateUpdateMessage(input);
      }
      
      public function deserializeAs_GameFightOptionStateUpdateMessage(input:IDataInput) : void {
         this.fightId = input.readShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GameFightOptionStateUpdateMessage.fightId.");
         }
         else
         {
            this.teamId = input.readByte();
            if(this.teamId < 0)
            {
               throw new Error("Forbidden value (" + this.teamId + ") on element of GameFightOptionStateUpdateMessage.teamId.");
            }
            else
            {
               this.option = input.readByte();
               if(this.option < 0)
               {
                  throw new Error("Forbidden value (" + this.option + ") on element of GameFightOptionStateUpdateMessage.option.");
               }
               else
               {
                  this.state = input.readBoolean();
                  return;
               }
            }
         }
      }
   }
}
