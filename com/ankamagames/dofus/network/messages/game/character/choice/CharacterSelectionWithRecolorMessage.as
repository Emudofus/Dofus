package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterSelectionWithRecolorMessage extends CharacterSelectionMessage implements INetworkMessage
   {
      
      public function CharacterSelectionWithRecolorMessage() {
         this.indexedColor = new Vector.<int>();
         super();
      }
      
      public static const protocolId:uint = 6075;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var indexedColor:Vector.<int>;
      
      override public function getMessageId() : uint {
         return 6075;
      }
      
      public function initCharacterSelectionWithRecolorMessage(id:int=0, indexedColor:Vector.<int>=null) : CharacterSelectionWithRecolorMessage {
         super.initCharacterSelectionMessage(id);
         this.indexedColor = indexedColor;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.indexedColor = new Vector.<int>();
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterSelectionWithRecolorMessage(output);
      }
      
      public function serializeAs_CharacterSelectionWithRecolorMessage(output:IDataOutput) : void {
         super.serializeAs_CharacterSelectionMessage(output);
         output.writeShort(this.indexedColor.length);
         var _i1:uint = 0;
         while(_i1 < this.indexedColor.length)
         {
            output.writeInt(this.indexedColor[_i1]);
            _i1++;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterSelectionWithRecolorMessage(input);
      }
      
      public function deserializeAs_CharacterSelectionWithRecolorMessage(input:IDataInput) : void {
         var _val1:* = 0;
         super.deserialize(input);
         var _indexedColorLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _indexedColorLen)
         {
            _val1 = input.readInt();
            this.indexedColor.push(_val1);
            _i1++;
         }
      }
   }
}
