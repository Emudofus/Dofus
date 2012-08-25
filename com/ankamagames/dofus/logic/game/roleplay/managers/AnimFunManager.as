package com.ankamagames.dofus.logic.game.roleplay.managers
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.datacenter.monsters.*;
    import com.ankamagames.dofus.datacenter.npcs.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.common.misc.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.dofus.logic.game.roleplay.types.*;
    import com.ankamagames.dofus.network.types.game.context.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.*;
    import com.ankamagames.dofus.types.entities.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.sequencer.*;
    import com.ankamagames.jerakine.utils.errors.*;
    import com.ankamagames.jerakine.utils.prng.*;
    import com.ankamagames.tiphon.display.*;
    import com.ankamagames.tiphon.sequence.*;
    import flash.utils.*;

    final public class AnimFunManager extends Object
    {
        private var _animFunNpcData:AnimFunNpcData;
        private var _animFunMonsterData:AnimFunMonsterData;
        private var _timerList:Vector.<AnimFunTimer>;
        private var _animDelays:Array;
        private var _animDelaysSum:uint;
        private var _minDelay:int = 40000;
        private var _maxDelay:int = 80000;
        private var _mapId:int = -1;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimFunManager));
        public static const ANIM_FUN_TIMER_MIN:int = 40000;
        public static const ANIM_FUN_TIMER_MAX:int = 80000;
        public static const FAST_ANIM_FUN_TIMER_MIN:int = 1000;
        public static const FAST_ANIM_FUN_TIMER_MAX:int = 5000;
        public static const ANIM_DELAY_SIZE:uint = 20;
        private static var _self:AnimFunManager;

        public function AnimFunManager()
        {
            this._timerList = new Vector.<AnimFunTimer>;
            if (_self)
            {
                throw new SingletonError();
            }
            this.fastDelay = false;
            return;
        }// end function

        public function set fastDelay(param1:Boolean) : void
        {
            if (param1 != this.fastDelay)
            {
                if (param1)
                {
                    this._minDelay = FAST_ANIM_FUN_TIMER_MIN;
                    this._maxDelay = FAST_ANIM_FUN_TIMER_MAX;
                }
                else
                {
                    this._minDelay = ANIM_FUN_TIMER_MAX;
                    this._maxDelay = ANIM_FUN_TIMER_MAX;
                }
                if (this._mapId != -1)
                {
                    this.initializeByMap(this._mapId);
                }
            }
            return;
        }// end function

        public function get fastDelay() : Boolean
        {
            return this._minDelay == 1000;
        }// end function

        public function initializeByMap(param1:uint) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:uint = 0;
            var _loc_6:uint = 0;
            _log.info("Initialize AnimFunManager for map " + param1);
            this._mapId = param1;
            var _loc_2:* = new ParkMillerCarta();
            _loc_2.seed(param1 + 5435);
            this._animDelays = new Array();
            this._animDelaysSum = 0;
            var _loc_3:uint = 0;
            while (_loc_3 < ANIM_DELAY_SIZE)
            {
                
                _loc_4 = _loc_2.nextIntR(this._minDelay, this._maxDelay);
                _loc_5 = _loc_2.nextInt();
                _loc_6 = _loc_2.nextInt();
                this._animDelays.push({delay:_loc_4, actor:_loc_5, anim:_loc_6});
                this._animDelaysSum = this._animDelaysSum + _loc_4;
                _loc_3 = _loc_3 + 1;
            }
            this.stopAllTimer();
            this.initNextAnimFun();
            return;
        }// end function

        public function get running() : Boolean
        {
            var _loc_1:AnimFunTimer = null;
            for each (_loc_1 in this._timerList)
            {
                
                if (_loc_1.running)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function restart() : void
        {
            if (!this.running)
            {
                this.initNextAnimFun();
            }
            return;
        }// end function

        public function newAnimFunTimer(param1:int, param2:int, param3:int) : void
        {
            this._timerList.push(new AnimFunTimer(param1, param2, param3, this.onTimer));
            return;
        }// end function

        public function stopAllTimer() : void
        {
            var _loc_1:* = this._timerList.length;
            var _loc_2:int = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._timerList[_loc_2].destroy();
                _loc_2++;
            }
            this._timerList = new Vector.<AnimFunTimer>;
            return;
        }// end function

        private function onTimer(param1:AnimFunTimer) : void
        {
            var _loc_2:Object = null;
            var _loc_4:RoleplayEntitiesFrame = null;
            var _loc_5:TiphonSprite = null;
            var _loc_6:GameContextActorInformations = null;
            var _loc_7:SerialSequencer = null;
            var _loc_8:GameRolePlayGroupMonsterInformations = null;
            var _loc_9:Monster = null;
            var _loc_10:GameRolePlayNpcInformations = null;
            var _loc_11:Npc = null;
            _log.info("Timer reached, run animFun.");
            var _loc_3:* = this._timerList.indexOf(param1);
            if (_loc_3 != -1)
            {
                param1.destroy();
                this._timerList.splice(_loc_3, 1);
            }
            if (this.getIsMapStatic())
            {
                _loc_4 = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
                if (!_loc_4)
                {
                    return;
                }
                _loc_5 = DofusEntities.getEntity(param1.actorId) as TiphonSprite;
                if (!_loc_5)
                {
                    return;
                }
                _loc_6 = _loc_4.getEntityInfos(param1.actorId);
                if (_loc_6 is GameRolePlayGroupMonsterInformations)
                {
                    _loc_8 = _loc_6 as GameRolePlayGroupMonsterInformations;
                    _loc_9 = Monster.getMonsterById(_loc_8.mainCreatureGenericId);
                    if (!_loc_9 || _loc_9.animFunList.length == 0)
                    {
                        return;
                    }
                    _loc_2 = _loc_9.animFunList;
                }
                else if (_loc_6 is GameRolePlayNpcInformations)
                {
                    _loc_10 = _loc_6 as GameRolePlayNpcInformations;
                    _loc_11 = Npc.getNpcById(_loc_10.npcId);
                    if (!_loc_11)
                    {
                        return;
                    }
                    _loc_2 = _loc_11.animFunList;
                }
                else
                {
                    return;
                }
                _loc_7 = new SerialSequencer();
                _loc_7.addStep(new PlayAnimationStep(_loc_5, _loc_2[param1.animId].animName));
                _loc_7.start();
            }
            this.initNextAnimFun();
            return;
        }// end function

        private function initNextAnimFun() : void
        {
            var _loc_2:Object = null;
            var _loc_3:int = 0;
            var _loc_4:int = 0;
            if (this._animDelaysSum == 0)
            {
                _log.error("try to init a new animFun with a 0 delay sum");
                return;
            }
            var _loc_1:* = TimeManager.getInstance().getTimestamp();
            _loc_1 = _loc_1 % this._animDelaysSum;
            for each (_loc_2 in this._animDelays)
            {
                
                if (_loc_1 > _loc_2.delay)
                {
                    _loc_1 = _loc_1 - _loc_2.delay;
                    continue;
                }
                _loc_3 = this.randomActor(_loc_2.actor);
                _loc_4 = this.randomAnim(_loc_3, _loc_2.anim);
                if (_loc_3 != 0)
                {
                    _log.info("waiting " + (_loc_2.delay - _loc_1) + " until next anim fun");
                    this.newAnimFunTimer(_loc_3, _loc_2.delay - _loc_1, _loc_4);
                }
                return;
            }
            return;
        }// end function

        private function randomActor(param1:int) : int
        {
            var _loc_5:GameContextActorInformations = null;
            var _loc_6:Monster = null;
            var _loc_7:Npc = null;
            var _loc_8:int = 0;
            var _loc_2:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            var _loc_3:* = _loc_2.getEntitiesDictionnary();
            var _loc_4:* = new Array();
            for each (_loc_5 in _loc_3)
            {
                
                if (_loc_5 is GameRolePlayGroupMonsterInformations)
                {
                    _loc_6 = Monster.getMonsterById((_loc_5 as GameRolePlayGroupMonsterInformations).mainCreatureGenericId);
                    if (_loc_6 && _loc_6.animFunList.length != 0)
                    {
                        _loc_4.push(_loc_5);
                    }
                    continue;
                }
                if (_loc_5 is GameRolePlayNpcInformations)
                {
                    _loc_7 = Npc.getNpcById((_loc_5 as GameRolePlayNpcInformations).npcId);
                    if (_loc_7 && _loc_7.animFunList.length != 0)
                    {
                        _loc_4.push(_loc_5);
                    }
                }
            }
            if (_loc_4.length)
            {
                _loc_8 = param1 % _loc_4.length;
                return _loc_4[_loc_8].contextualId;
            }
            return 0;
        }// end function

        private function randomAnim(param1:int, param2:int) : int
        {
            var _loc_3:Object = null;
            var _loc_11:GameRolePlayGroupMonsterInformations = null;
            var _loc_12:Monster = null;
            var _loc_13:GameRolePlayNpcInformations = null;
            var _loc_14:Npc = null;
            var _loc_4:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if (!(Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame))
            {
                return 0;
            }
            var _loc_5:* = _loc_4.getEntityInfos(param1);
            if (_loc_4.getEntityInfos(param1) is GameRolePlayGroupMonsterInformations)
            {
                _loc_11 = _loc_5 as GameRolePlayGroupMonsterInformations;
                _loc_12 = Monster.getMonsterById(_loc_11.mainCreatureGenericId);
                if (!_loc_12)
                {
                    return 0;
                }
                _loc_3 = _loc_12.animFunList;
            }
            else if (_loc_5 is GameRolePlayNpcInformations)
            {
                _loc_13 = _loc_5 as GameRolePlayNpcInformations;
                _loc_14 = Npc.getNpcById(_loc_13.npcId);
                if (!_loc_14)
                {
                    return 0;
                }
                _loc_3 = _loc_14.animFunList;
            }
            else
            {
                return 0;
            }
            var _loc_6:int = 0;
            var _loc_7:int = 0;
            var _loc_8:* = _loc_3.length;
            var _loc_9:int = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_7 = _loc_7 + _loc_3[_loc_9].animWeight;
                _loc_9++;
            }
            var _loc_10:* = param2 % _loc_7;
            _loc_7 = 0;
            _loc_9 = 0;
            while (_loc_9 < _loc_8)
            {
                
                _loc_7 = _loc_7 + _loc_3[_loc_9].animWeight;
                if (_loc_7 > _loc_10)
                {
                    return _loc_9;
                }
                _loc_9++;
            }
            return 0;
        }// end function

        private function getIsMapStatic() : Boolean
        {
            var _loc_4:GameContextActorInformations = null;
            var _loc_5:AnimatedCharacter = null;
            var _loc_1:* = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            var _loc_2:* = _loc_1.getEntitiesDictionnary();
            var _loc_3:* = new Array();
            for each (_loc_4 in _loc_2)
            {
                
                _loc_5 = DofusEntities.getEntity(_loc_4.contextualId) as AnimatedCharacter;
                if (_loc_5 && _loc_5.isMoving)
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function getInstance() : AnimFunManager
        {
            if (!_self)
            {
                _self = new AnimFunManager;
            }
            return _self;
        }// end function

    }
}
