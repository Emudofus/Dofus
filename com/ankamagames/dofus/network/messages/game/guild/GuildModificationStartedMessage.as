package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   
   public class GuildModificationStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildModificationStartedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6324;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var canChangeName:Boolean = false;
      
      public var canChangeEmblem:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6324;
      }
      
      public function initGuildModificationStartedMessage(canChangeName:Boolean = false, canChangeEmblem:Boolean = false) : GuildModificationStartedMessage {
         this.canChangeName = canChangeName;
         this.canChangeEmblem = canChangeEmblem;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.canChangeName = false;
         this.canChangeEmblem = false;
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
         this.serializeAs_GuildModificationStartedMessage(output);
      }
      
      public function serializeAs_GuildModificationStartedMessage(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.canChangeName);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.canChangeEmblem);
         output.writeByte(_box0);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildModificationStartedMessage(input);
      }
      
      public function deserializeAs_GuildModificationStartedMessage(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.canChangeName = BooleanByteWrapper.getFlag(_box0,0);
         this.canChangeEmblem = BooleanByteWrapper.getFlag(_box0,1);
      }
   }
}
