package com.ankamagames.dofus.network.messages.game.context.roleplay.spell
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initSpellForgottenMessage(param1:Vector.<uint>=null, param2:uint=0) : SpellForgottenMessage {
         this.spellsId = param1;
         this.boostPoint = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.spellsId = new Vector.<uint>();
         this.boostPoint = 0;
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
         this.serializeAs_SpellForgottenMessage(param1);
      }
      
      public function serializeAs_SpellForgottenMessage(param1:IDataOutput) : void {
         param1.writeShort(this.spellsId.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.spellsId.length)
         {
            if(this.spellsId[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.spellsId[_loc2_] + ") on element 1 (starting at 1) of spellsId.");
            }
            else
            {
               param1.writeShort(this.spellsId[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         if(this.boostPoint < 0)
         {
            throw new Error("Forbidden value (" + this.boostPoint + ") on element boostPoint.");
         }
         else
         {
            param1.writeShort(this.boostPoint);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_SpellForgottenMessage(param1);
      }
      
      public function deserializeAs_SpellForgottenMessage(param1:IDataInput) : void {
         var _loc4_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readShort();
            if(_loc4_ < 0)
            {
               throw new Error("Forbidden value (" + _loc4_ + ") on elements of spellsId.");
            }
            else
            {
               this.spellsId.push(_loc4_);
               _loc3_++;
               continue;
            }
         }
         this.boostPoint = param1.readShort();
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
