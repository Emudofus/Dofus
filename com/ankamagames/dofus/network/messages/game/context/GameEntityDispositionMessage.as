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
      
      public function initGameEntityDispositionMessage(param1:IdentifiedEntityDispositionInformations=null) : GameEntityDispositionMessage {
         this.disposition = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.disposition = new IdentifiedEntityDispositionInformations();
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
         this.serializeAs_GameEntityDispositionMessage(param1);
      }
      
      public function serializeAs_GameEntityDispositionMessage(param1:IDataOutput) : void {
         this.disposition.serializeAs_IdentifiedEntityDispositionInformations(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameEntityDispositionMessage(param1);
      }
      
      public function deserializeAs_GameEntityDispositionMessage(param1:IDataInput) : void {
         this.disposition = new IdentifiedEntityDispositionInformations();
         this.disposition.deserialize(param1);
      }
   }
}
