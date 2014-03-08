package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initTitlesAndOrnamentsListMessage(param1:Vector.<uint>=null, param2:Vector.<uint>=null, param3:uint=0, param4:uint=0) : TitlesAndOrnamentsListMessage {
         this.titles = param1;
         this.ornaments = param2;
         this.activeTitle = param3;
         this.activeOrnament = param4;
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
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_TitlesAndOrnamentsListMessage(param1);
      }
      
      public function serializeAs_TitlesAndOrnamentsListMessage(param1:IDataOutput) : void {
         param1.writeShort(this.titles.length);
         var _loc2_:uint = 0;
         while(_loc2_ < this.titles.length)
         {
            if(this.titles[_loc2_] < 0)
            {
               throw new Error("Forbidden value (" + this.titles[_loc2_] + ") on element 1 (starting at 1) of titles.");
            }
            else
            {
               param1.writeShort(this.titles[_loc2_]);
               _loc2_++;
               continue;
            }
         }
         param1.writeShort(this.ornaments.length);
         var _loc3_:uint = 0;
         while(_loc3_ < this.ornaments.length)
         {
            if(this.ornaments[_loc3_] < 0)
            {
               throw new Error("Forbidden value (" + this.ornaments[_loc3_] + ") on element 2 (starting at 1) of ornaments.");
            }
            else
            {
               param1.writeShort(this.ornaments[_loc3_]);
               _loc3_++;
               continue;
            }
         }
         if(this.activeTitle < 0)
         {
            throw new Error("Forbidden value (" + this.activeTitle + ") on element activeTitle.");
         }
         else
         {
            param1.writeShort(this.activeTitle);
            if(this.activeOrnament < 0)
            {
               throw new Error("Forbidden value (" + this.activeOrnament + ") on element activeOrnament.");
            }
            else
            {
               param1.writeShort(this.activeOrnament);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_TitlesAndOrnamentsListMessage(param1);
      }
      
      public function deserializeAs_TitlesAndOrnamentsListMessage(param1:IDataInput) : void {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:uint = param1.readUnsignedShort();
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = param1.readShort();
            if(_loc6_ < 0)
            {
               throw new Error("Forbidden value (" + _loc6_ + ") on elements of titles.");
            }
            else
            {
               this.titles.push(_loc6_);
               _loc3_++;
               continue;
            }
         }
         var _loc4_:uint = param1.readUnsignedShort();
         var _loc5_:uint = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1.readShort();
            if(_loc7_ < 0)
            {
               throw new Error("Forbidden value (" + _loc7_ + ") on elements of ornaments.");
            }
            else
            {
               this.ornaments.push(_loc7_);
               _loc5_++;
               continue;
            }
         }
         this.activeTitle = param1.readShort();
         if(this.activeTitle < 0)
         {
            throw new Error("Forbidden value (" + this.activeTitle + ") on element of TitlesAndOrnamentsListMessage.activeTitle.");
         }
         else
         {
            this.activeOrnament = param1.readShort();
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
