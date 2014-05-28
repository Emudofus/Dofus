package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ServerOptionalFeaturesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ServerOptionalFeaturesMessage() {
         this.features = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6305;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var features:Vector.<uint>;
      
      override public function getMessageId() : uint {
         return 6305;
      }
      
      public function initServerOptionalFeaturesMessage(features:Vector.<uint> = null) : ServerOptionalFeaturesMessage {
         this.features = features;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.features = new Vector.<uint>();
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
         this.serializeAs_ServerOptionalFeaturesMessage(output);
      }
      
      public function serializeAs_ServerOptionalFeaturesMessage(output:IDataOutput) : void {
         output.writeShort(this.features.length);
         var _i1:uint = 0;
         while(_i1 < this.features.length)
         {
            if(this.features[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.features[_i1] + ") on element 1 (starting at 1) of features.");
            }
            else
            {
               output.writeShort(this.features[_i1]);
               _i1++;
               continue;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ServerOptionalFeaturesMessage(input);
      }
      
      public function deserializeAs_ServerOptionalFeaturesMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _featuresLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _featuresLen)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of features.");
            }
            else
            {
               this.features.push(_val1);
               _i1++;
               continue;
            }
         }
      }
   }
}
