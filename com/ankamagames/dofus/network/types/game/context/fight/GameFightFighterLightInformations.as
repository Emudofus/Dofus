package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import flash.utils.IDataInput;
   
   public class GameFightFighterLightInformations extends Object implements INetworkType
   {
      
      public function GameFightFighterLightInformations() {
         super();
      }
      
      public static const protocolId:uint = 413;
      
      public var id:int = 0;
      
      public var wave:int = 0;
      
      public var level:uint = 0;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      public var alive:Boolean = false;
      
      public function getTypeId() : uint {
         return 413;
      }
      
      public function initGameFightFighterLightInformations(id:int=0, wave:int=0, level:uint=0, breed:int=0, sex:Boolean=false, alive:Boolean=false) : GameFightFighterLightInformations {
         this.id = id;
         this.wave = wave;
         this.level = level;
         this.breed = breed;
         this.sex = sex;
         this.alive = alive;
         return this;
      }
      
      public function reset() : void {
         this.id = 0;
         this.wave = 0;
         this.level = 0;
         this.breed = 0;
         this.sex = false;
         this.alive = false;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_GameFightFighterLightInformations(output);
      }
      
      public function serializeAs_GameFightFighterLightInformations(output:IDataOutput) : void {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.sex);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.alive);
         output.writeByte(_box0);
         output.writeInt(this.id);
         output.writeInt(this.wave);
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element level.");
         }
         else
         {
            output.writeShort(this.level);
            output.writeByte(this.breed);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GameFightFighterLightInformations(input);
      }
      
      public function deserializeAs_GameFightFighterLightInformations(input:IDataInput) : void {
         var _box0:uint = input.readByte();
         this.sex = BooleanByteWrapper.getFlag(_box0,0);
         this.alive = BooleanByteWrapper.getFlag(_box0,1);
         this.id = input.readInt();
         this.wave = input.readInt();
         this.level = input.readShort();
         if(this.level < 0)
         {
            throw new Error("Forbidden value (" + this.level + ") on element of GameFightFighterLightInformations.level.");
         }
         else
         {
            this.breed = input.readByte();
            return;
         }
      }
   }
}
