package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockContentInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GuildPaddockBoughtMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GuildPaddockBoughtMessage() {
         this.paddockInfo = new PaddockContentInformations();
         super();
      }
      
      public static const protocolId:uint = 5952;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var paddockInfo:PaddockContentInformations;
      
      override public function getMessageId() : uint {
         return 5952;
      }
      
      public function initGuildPaddockBoughtMessage(param1:PaddockContentInformations=null) : GuildPaddockBoughtMessage {
         this.paddockInfo = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.paddockInfo = new PaddockContentInformations();
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
         this.serializeAs_GuildPaddockBoughtMessage(param1);
      }
      
      public function serializeAs_GuildPaddockBoughtMessage(param1:IDataOutput) : void {
         this.paddockInfo.serializeAs_PaddockContentInformations(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GuildPaddockBoughtMessage(param1);
      }
      
      public function deserializeAs_GuildPaddockBoughtMessage(param1:IDataInput) : void {
         this.paddockInfo = new PaddockContentInformations();
         this.paddockInfo.deserialize(param1);
      }
   }
}
