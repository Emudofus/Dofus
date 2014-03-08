package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
   import com.ankamagames.dofus.network.types.game.context.ActorOrientation;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameMapChangeOrientationsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameMapChangeOrientationsMessage() {
         this.orientations = new Vector.<ActorOrientation>();
         super();
      }
      
      public static const protocolId:uint = 6155;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var orientations:Vector.<ActorOrientation>;
      
      override public function getMessageId() : uint {
         return 6155;
      }
      
      public function initGameMapChangeOrientationsMessage(param1:Vector.<ActorOrientation>=null) : GameMapChangeOrientationsMessage {
         this.orientations = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.orientations = new Vector.<ActorOrientation>();
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
         this.serializeAs_GameMapChangeOrientationsMessage(param1);
      }
      
      public function serializeAs_GameMapChangeOrientationsMessage(param1:IDataOutput) : void {
         param1.writeShort(this.orientations.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.orientations.length)
         {
            (this.orientations[_loc2_] as ActorOrientation).serializeAs_ActorOrientation(param1);
            _loc2_++;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameMapChangeOrientationsMessage(param1);
      }
      
      public function deserializeAs_GameMapChangeOrientationsMessage(param1:IDataInput) : void {
         var _loc4_:ActorOrientation = null;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new ActorOrientation();
            _loc4_.deserialize(param1);
            this.orientations.push(_loc4_);
            _loc3_++;
         }
      }
   }
}
