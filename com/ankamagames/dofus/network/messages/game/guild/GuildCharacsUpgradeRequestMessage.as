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
      
      public function initGuildCharacsUpgradeRequestMessage(charaTypeTarget:uint=0) : GuildCharacsUpgradeRequestMessage {
         this.charaTypeTarget = charaTypeTarget;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.charaTypeTarget = 0;
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
         this.serializeAs_GuildCharacsUpgradeRequestMessage(output);
      }
      
      public function serializeAs_GuildCharacsUpgradeRequestMessage(output:IDataOutput) : void {
         output.writeByte(this.charaTypeTarget);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildCharacsUpgradeRequestMessage(input);
      }
      
      public function deserializeAs_GuildCharacsUpgradeRequestMessage(input:IDataInput) : void {
         this.charaTypeTarget = input.readByte();
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
