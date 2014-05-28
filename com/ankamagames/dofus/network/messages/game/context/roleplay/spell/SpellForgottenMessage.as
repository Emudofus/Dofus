package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SpellForgottenMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function SpellForgottenMessage() {
         this.spellsId = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 5834;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var spellsId:Vector.<uint>;
      
      public var boostPoint:uint = 0;
      
      override public function getMessageId() : uint {
         return 5834;
      }
      
      public function initSpellForgottenMessage(spellsId:Vector.<uint> = null, boostPoint:uint = 0) : SpellForgottenMessage {
         this.spellsId = spellsId;
         this.boostPoint = boostPoint;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellsId = new Vector.<uint>();
         this.boostPoint = 0;
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
         this.serializeAs_SpellForgottenMessage(output);
      }
      
      public function serializeAs_SpellForgottenMessage(output:IDataOutput) : void {
         output.writeShort(this.spellsId.length);
         var _i1:uint = 0;
         while(_i1 < this.spellsId.length)
         {
            if(this.spellsId[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.spellsId[_i1] + ") on element 1 (starting at 1) of spellsId.");
            }
            else
            {
               output.writeShort(this.spellsId[_i1]);
               _i1++;
               continue;
            }
         }
         if(this.boostPoint < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoint + ") on element boostPoint.");
         }
         else
         {
            output.writeShort(this.boostPoint);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_SpellForgottenMessage(input);
      }
      
      public function deserializeAs_SpellForgottenMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _spellsIdLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _spellsIdLen)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of spellsId.");
            }
            else
            {
               this.spellsId.push(_val1);
               _i1++;
               continue;
            }
         }
         this.boostPoint = input.readShort();
         if(this.boostPoint < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoint + ") on element of SpellForgottenMessage.boostPoint.");
         }
         else
         {
            return;
         }
      }
   }
}
