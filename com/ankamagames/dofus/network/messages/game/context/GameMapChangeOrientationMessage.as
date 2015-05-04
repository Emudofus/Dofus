package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class GameMapChangeOrientationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameMapChangeOrientationMessage()
      {
         this.orientation = new ActorOrientation();
         super();
      }
      
      public static const protocolId:uint = 946;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var orientation:ActorOrientation;
      
      override public function getMessageId() : uint
      {
         return 946;
      }
      
      public function initGameMapChangeOrientationMessage(param1:ActorOrientation = null) : GameMapChangeOrientationMessage
      {
         this.orientation = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.orientation = new ActorOrientation();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_GameMapChangeOrientationMessage(param1);
      }
      
      public function serializeAs_GameMapChangeOrientationMessage(param1:ICustomDataOutput) : void
      {
         this.orientation.serializeAs_ActorOrientation(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_GameMapChangeOrientationMessage(param1);
      }
      
      public function deserializeAs_GameMapChangeOrientationMessage(param1:ICustomDataInput) : void
      {
         this.orientation = new ActorOrientation();
         this.orientation.deserialize(param1);
      }
   }
}
