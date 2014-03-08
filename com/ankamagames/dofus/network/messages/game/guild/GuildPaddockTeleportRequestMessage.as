package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildPaddockTeleportRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildPaddockTeleportRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5957;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var paddockId:int = 0;
      
      override public function getMessageId() : uint {
         return 5957;
      }
      
      public function initGuildPaddockTeleportRequestMessage(param1:int=0) : GuildPaddockTeleportRequestMessage {
         this.paddockId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.paddockId = 0;
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
         this.serializeAs_GuildPaddockTeleportRequestMessage(param1);
      }
      
      public function serializeAs_GuildPaddockTeleportRequestMessage(param1:IDataOutput) : void {
         param1.writeInt(this.paddockId);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildPaddockTeleportRequestMessage(param1);
      }
      
      public function deserializeAs_GuildPaddockTeleportRequestMessage(param1:IDataInput) : void {
         this.paddockId = param1.readInt();
      }
   }
}
