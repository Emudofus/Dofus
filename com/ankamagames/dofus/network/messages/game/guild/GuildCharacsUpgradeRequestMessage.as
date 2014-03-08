package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildCharacsUpgradeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildCharacsUpgradeRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5706;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var charaTypeTarget:uint = 0;
      
      override public function getMessageId() : uint {
         return 5706;
      }
      
      public function initGuildCharacsUpgradeRequestMessage(param1:uint=0) : GuildCharacsUpgradeRequestMessage {
         this.charaTypeTarget = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.charaTypeTarget = 0;
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
         this.serializeAs_GuildCharacsUpgradeRequestMessage(param1);
      }
      
      public function serializeAs_GuildCharacsUpgradeRequestMessage(param1:IDataOutput) : void {
         param1.writeByte(this.charaTypeTarget);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildCharacsUpgradeRequestMessage(param1);
      }
      
      public function deserializeAs_GuildCharacsUpgradeRequestMessage(param1:IDataInput) : void {
         this.charaTypeTarget = param1.readByte();
         if(this.charaTypeTarget < 0)
         {
            throw new Error("Forbidden value (" + this.charaTypeTarget + ") on element of GuildCharacsUpgradeRequestMessage.charaTypeTarget.");
         }
         else
         {
            return;
         }
      }
   }
}
