package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameMapChangeOrientationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameMapChangeOrientationMessage() {
         this.orientation = new ActorOrientation();
         super();
      }
      
      public static const protocolId:uint = 946;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var orientation:ActorOrientation;
      
      override public function getMessageId() : uint {
         return 946;
      }
      
      public function initGameMapChangeOrientationMessage(orientation:ActorOrientation = null) : GameMapChangeOrientationMessage {
         this.orientation = orientation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.orientation = new ActorOrientation();
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
         this.serializeAs_GameMapChangeOrientationMessage(output);
      }
      
      public function serializeAs_GameMapChangeOrientationMessage(output:IDataOutput) : void {
         this.orientation.serializeAs_ActorOrientation(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameMapChangeOrientationMessage(input);
      }
      
      public function deserializeAs_GameMapChangeOrientationMessage(input:IDataInput) : void {
         this.orientation = new ActorOrientation();
         this.orientation.deserialize(input);
      }
   }
}
