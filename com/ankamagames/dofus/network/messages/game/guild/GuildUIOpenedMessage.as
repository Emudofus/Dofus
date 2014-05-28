package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class GuildUIOpenedMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function GuildUIOpenedMessage() {
         super();
      }

      public static const protocolId:uint = 5561;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var type:uint = 0;

      override public function getMessageId() : uint {
         return 5561;
      }

      public function initGuildUIOpenedMessage(type:uint=0) : GuildUIOpenedMessage {
         this.type=type;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.type=0;
         this._isInitialized=false;
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
         this.serializeAs_GuildUIOpenedMessage(output);
      }

      public function serializeAs_GuildUIOpenedMessage(output:IDataOutput) : void {
         output.writeByte(this.type);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildUIOpenedMessage(input);
      }

      public function deserializeAs_GuildUIOpenedMessage(input:IDataInput) : void {
         this.type=input.readByte();
         if(this.type<0)
         {
            throw new Error("Forbidden value ("+this.type+") on element of GuildUIOpenedMessage.type.");
         }
         else
         {
            return;
         }
      }
   }

}