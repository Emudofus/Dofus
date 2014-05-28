package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameEntityDispositionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameEntityDispositionMessage() {
         this.disposition = new IdentifiedEntityDispositionInformations();
         super();
      }
      
      public static const protocolId:uint = 5693;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var disposition:IdentifiedEntityDispositionInformations;
      
      override public function getMessageId() : uint {
         return 5693;
      }
      
      public function initGameEntityDispositionMessage(disposition:IdentifiedEntityDispositionInformations = null) : GameEntityDispositionMessage {
         this.disposition = disposition;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.disposition = new IdentifiedEntityDispositionInformations();
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
         this.serializeAs_GameEntityDispositionMessage(output);
      }
      
      public function serializeAs_GameEntityDispositionMessage(output:IDataOutput) : void {
         this.disposition.serializeAs_IdentifiedEntityDispositionInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameEntityDispositionMessage(input);
      }
      
      public function deserializeAs_GameEntityDispositionMessage(input:IDataInput) : void {
         this.disposition = new IdentifiedEntityDispositionInformations();
         this.disposition.deserialize(input);
      }
   }
}
