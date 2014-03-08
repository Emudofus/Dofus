package com.ankamagames.dofus.network.messages.web.krosmaster
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class KrosmasterPlayingStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function KrosmasterPlayingStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6347;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var playing:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6347;
      }
      
      public function initKrosmasterPlayingStatusMessage(playing:Boolean=false) : KrosmasterPlayingStatusMessage {
         this.playing = playing;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.playing = false;
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
         this.serializeAs_KrosmasterPlayingStatusMessage(output);
      }
      
      public function serializeAs_KrosmasterPlayingStatusMessage(output:IDataOutput) : void {
         output.writeBoolean(this.playing);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_KrosmasterPlayingStatusMessage(input);
      }
      
      public function deserializeAs_KrosmasterPlayingStatusMessage(input:IDataInput) : void {
         this.playing = input.readBoolean();
      }
   }
}
