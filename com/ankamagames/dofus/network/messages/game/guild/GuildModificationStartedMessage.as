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
      
      public function initGuildModificationStartedMessage(param1:Boolean=false, param2:Boolean=false) : GuildModificationStartedMessage {
         this.canChangeName = param1;
         this.canChangeEmblem = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.canChangeName = false;
         this.canChangeEmblem = false;
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
         this.serializeAs_GuildModificationStartedMessage(param1);
      }
      
      public function serializeAs_GuildModificationStartedMessage(param1:IDataOutput) : void {
         var _loc2_:uint = 0;
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,0,this.canChangeName);
         _loc2_ = BooleanByteWrapper.setFlag(_loc2_,1,this.canChangeEmblem);
         param1.writeByte(_loc2_);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildModificationStartedMessage(param1);
      }
      
      public function deserializeAs_GuildModificationStartedMessage(param1:IDataInput) : void {
         var _loc2_:uint = param1.readByte();
         this.canChangeName = BooleanByteWrapper.getFlag(_loc2_,0);
         this.canChangeEmblem = BooleanByteWrapper.getFlag(_loc2_,1);
      }
   }
}
