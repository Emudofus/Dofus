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
      
      public function initGuildPaddockBoughtMessage(paddockInfo:PaddockContentInformations=null) : GuildPaddockBoughtMessage {
         this.paddockInfo = paddockInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.paddockInfo = new PaddockContentInformations();
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
         this.serializeAs_GuildPaddockBoughtMessage(output);
      }
      
      public function serializeAs_GuildPaddockBoughtMessage(output:IDataOutput) : void {
         this.paddockInfo.serializeAs_PaddockContentInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GuildPaddockBoughtMessage(input);
      }
      
      public function deserializeAs_GuildPaddockBoughtMessage(input:IDataInput) : void {
         this.paddockInfo = new PaddockContentInformations();
         this.paddockInfo.deserialize(input);
      }
   }
}
