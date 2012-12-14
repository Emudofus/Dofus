package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.datacenter.quest.*;
    import com.ankamagames.dofus.internalDatacenter.items.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.quest.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class QuestApi extends Object implements IApi
    {
        protected var _log:Logger;
        private var _module:UiModule;

        public function QuestApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(QuestApi));
            return;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getQuestInformations(param1:int) : Object
        {
            return this.getQuestFrame().getQuestInformations(param1);
        }// end function

        public function getAllQuests() : Vector.<Object>
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_1:* = new Vector.<Object>(0, false);
            var _loc_2:* = this.getQuestFrame().getActiveQuests();
            for each (_loc_3 in _loc_2)
            {
                
                _loc_1.push({id:_loc_3.questId, status:true});
            }
            _loc_4 = this.getQuestFrame().getCompletedQuests();
            for each (_loc_5 in _loc_4)
            {
                
                _loc_1.push({id:_loc_5, status:false});
            }
            return _loc_1;
        }// end function

        public function getActiveQuests() : Vector.<uint>
        {
            var _loc_3:* = null;
            var _loc_1:* = new Vector.<uint>;
            var _loc_2:* = this.getQuestFrame().getActiveQuests();
            for each (_loc_3 in _loc_2)
            {
                
                _loc_1.push(_loc_3.questId);
            }
            return _loc_1;
        }// end function

        public function getCompletedQuests() : Vector.<uint>
        {
            return this.getQuestFrame().getCompletedQuests();
        }// end function

        public function getAllQuestsOrderByCategory(param1:Boolean = false) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_6:* = null;
            var _loc_9:* = 0;
            var _loc_10:* = null;
            var _loc_2:* = new Array();
            var _loc_5:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = this.getQuestFrame().getActiveQuests();
            _loc_5 = _loc_5 + _loc_8.length;
            for each (_loc_4 in _loc_8)
            {
                
                _loc_3 = Quest.getQuestById(_loc_4.questId);
                _loc_7 = _loc_3.category.order;
                if (_loc_7 > _loc_2.length || !_loc_2[_loc_7])
                {
                    _loc_6 = new Object();
                    _loc_6.data = new Array();
                    _loc_6.id = _loc_3.categoryId;
                    _loc_2[_loc_7] = _loc_6;
                }
                _loc_2[_loc_7].data.push({id:_loc_4.questId, status:true});
            }
            if (param1)
            {
                _loc_10 = this.getQuestFrame().getCompletedQuests();
                _loc_5 = _loc_5 + _loc_10.length;
                for each (_loc_9 in _loc_10)
                {
                    
                    _loc_3 = Quest.getQuestById(_loc_9);
                    _loc_7 = _loc_3.category.order;
                    if (_loc_7 > _loc_2.length || !_loc_2[_loc_7])
                    {
                        _loc_6 = new Object();
                        _loc_6.data = new Array();
                        _loc_6.id = _loc_3.categoryId;
                        _loc_2[_loc_7] = _loc_6;
                    }
                    _loc_2[_loc_7].data.push({id:_loc_9, status:false});
                }
            }
            return _loc_2;
        }// end function

        public function getTutorialReward() : Vector.<ItemWrapper>
        {
            var _loc_1:* = new Vector.<ItemWrapper>;
            _loc_1.push(ItemWrapper.create(0, 0, 10785, 1, null, false));
            _loc_1.push(ItemWrapper.create(0, 0, 10794, 1, null, false));
            _loc_1.push(ItemWrapper.create(0, 0, 10797, 1, null, false));
            _loc_1.push(ItemWrapper.create(0, 0, 10798, 1, null, false));
            _loc_1.push(ItemWrapper.create(0, 0, 10799, 1, null, false));
            _loc_1.push(ItemWrapper.create(0, 0, 10784, 1, null, false));
            _loc_1.push(ItemWrapper.create(0, 0, 10800, 1, null, false));
            _loc_1.push(ItemWrapper.create(0, 0, 10801, 1, null, false));
            return _loc_1;
        }// end function

        public function getNotificationList() : Array
        {
            return QuestFrame.notificationList;
        }// end function

        public function getFinishedAchievementsIds() : Vector.<uint>
        {
            return this.getQuestFrame().finishedAchievementsIds;
        }// end function

        public function isAchievementFinished(param1:int) : Boolean
        {
            return this.getQuestFrame().finishedAchievementsIds.indexOf(param1) != -1;
        }// end function

        public function getAchievementKamasReward(param1:Achievement, param2:int = 0) : Number
        {
            if (param2 == 0)
            {
                param2 = PlayedCharacterManager.getInstance().infos.level;
            }
            return param1.getKamasReward(param2);
        }// end function

        public function getAchievementExperienceReward(param1:Achievement, param2:int = 0) : Number
        {
            if (param2 == 0)
            {
                param2 = PlayedCharacterManager.getInstance().infos.level;
            }
            return param1.getExperienceReward(param2, PlayedCharacterManager.getInstance().experiencePercent);
        }// end function

        public function getRewardableAchievements() : Vector.<AchievementRewardable>
        {
            return this.getQuestFrame().rewardableAchievements;
        }// end function

        private function getQuestFrame() : QuestFrame
        {
            return Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
        }// end function

    }
}
