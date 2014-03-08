package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.*;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class TitlesAndOrnamentsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TitlesAndOrnamentsListMessage() {
         this.titles = new Vector.<uint>();
         this.ornaments = new Vector.<uint>();
         super();
      }
      
      public static const protocolId:uint = 6367;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var titles:Vector.<uint>;
      
      public var ornaments:Vector.<uint>;
      
      public var activeTitle:uint = 0;
      
      public var activeOrnament:uint = 0;
      
      override public function getMessageId() : uint {
         return 6367;
      }
      
      public function initTitlesAndOrnamentsListMessage(titles:Vector.<uint>=null, ornaments:Vector.<uint>=null, activeTitle:uint=0, activeOrnament:uint=0) : TitlesAndOrnamentsListMessage {
         this.titles = titles;
         this.ornaments = ornaments;
         this.activeTitle = activeTitle;
         this.activeOrnament = activeOrnament;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.titles = new Vector.<uint>();
         this.ornaments = new Vector.<uint>();
         this.activeTitle = 0;
         this.activeOrnament = 0;
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
         this.serializeAs_TitlesAndOrnamentsListMessage(output);
      }
      
      public function serializeAs_TitlesAndOrnamentsListMessage(output:IDataOutput) : void {
         output.writeShort(this.titles.length);
         var _i1:uint = 0;
         while(_i1 < this.titles.length)
         {
            if(this.titles[_i1] < 0)
            {
               throw new Error("Forbidden value (" + this.titles[_i1] + ") on element 1 (starting at 1) of titles.");
            }
            else
            {
               output.writeShort(this.titles[_i1]);
               _i1++;
               continue;
            }
         }
         output.writeShort(this.ornaments.length);
         var _i2:uint = 0;
         while(_i2 < this.ornaments.length)
         {
            if(this.ornaments[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.ornaments[_i2] + ") on element 2 (starting at 1) of ornaments.");
            }
            else
            {
               output.writeShort(this.ornaments[_i2]);
               _i2++;
               continue;
            }
         }
         if(this.activeTitle < 0)
         {
            throw new Error("Forbidden value (" + this.activeTitle + ") on element activeTitle.");
         }
         else
         {
            output.writeShort(this.activeTitle);
            if(this.activeOrnament < 0)
            {
               throw new Error("Forbidden value (" + this.activeOrnament + ") on element activeOrnament.");
            }
            else
            {
               output.writeShort(this.activeOrnament);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_TitlesAndOrnamentsListMessage(input);
      }
      
      public function deserializeAs_TitlesAndOrnamentsListMessage(input:IDataInput) : void {
         var _val1:uint = 0;
         var _val2:uint = 0;
         var _titlesLen:uint = input.readUnsignedShort();
         var _i1:uint = 0;
         while(_i1 < _titlesLen)
         {
            _val1 = input.readShort();
            if(_val1 < 0)
            {
               throw new Error("Forbidden value (" + _val1 + ") on elements of titles.");
            }
            else
            {
               this.titles.push(_val1);
               _i1++;
               continue;
            }
         }
         var _ornamentsLen:uint = input.readUnsignedShort();
         var _i2:uint = 0;
         while(_i2 < _ornamentsLen)
         {
            _val2 = input.readShort();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of ornaments.");
            }
            else
            {
               this.ornaments.push(_val2);
               _i2++;
               continue;
            }
         }
         this.activeTitle = input.readShort();
         if(this.activeTitle < 0)
         {
            throw new Error("Forbidden value (" + this.activeTitle + ") on element of TitlesAndOrnamentsListMessage.activeTitle.");
         }
         else
         {
            this.activeOrnament = input.readShort();
            if(this.activeOrnament < 0)
            {
               throw new Error("Forbidden value (" + this.activeOrnament + ") on element of TitlesAndOrnamentsListMessage.activeOrnament.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
