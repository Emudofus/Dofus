package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildFightPlayersHelpersLeaveMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildFightPlayersHelpersLeaveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5719;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var fightId:Number = 0;
      
      public var playerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5719;
      }
      
      public function initGuildFightPlayersHelpersLeaveMessage(fightId:Number = 0, playerId:uint = 0) : GuildFightPlayersHelpersLeaveMessage {
         this.fightId = fightId;
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.fightId = 0;
         this.playerId = 0;
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
         this.serializeAs_GuildFightPlayersHelpersLeaveMessage(output);
      }
      
      public function serializeAs_GuildFightPlayersHelpersLeaveMessage(output:IDataOutput) : void {
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         else
         {
            output.writeDouble(this.fightId);
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            else
            {
               output.writeInt(this.playerId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildFightPlayersHelpersLeaveMessage(input);
      }
      
      public function deserializeAs_GuildFightPlayersHelpersLeaveMessage(input:IDataInput) : void {
         this.fightId = input.readDouble();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of GuildFightPlayersHelpersLeaveMessage.fightId.");
         }
         else
         {
            this.playerId = input.readInt();
            if(this.playerId < 0)
            {
               throw new Error("Forbidden value (" + this.playerId + ") on element of GuildFightPlayersHelpersLeaveMessage.playerId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
