;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))

(defrule welcome ""

  =>
  
  (assert (UI-state (display welcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule start_question ""
    (logical (start))
    =>
    (assert (UI-state (display startingQuestion)
                      (relation-asserted start_q)
                      (valid-answers startinganswer1 startinganswer2 startinganswer3 startinganswer4)))
)

(defrule who_asked ""
    (logical (start_q startinganswer1))
    =>
    (assert (UI-state (display whoAskedQuestion_2)
                      (relation-asserted who_a)
                      (valid-answers Yes No)))
)

(defrule are_you_celebrating ""
    (logical (who_a Yes))
    =>
    (assert (UI-state (display celebratingQuestion_4)
                      (relation-asserted celeb)
                      (valid-answers Yes No)))
)

(defrule answer_bubbly ""
    (logical (or
    (celeb Yes)
    (likePerson Yes)
    (longTime Yes)
    ))
    =>
    (assert (UI-state (display bubblyAnswer)
                      (relation-asserted bubbly)
                      (state final)))
)

(defrule worried ""
    (logical (celeb No))
    =>
    (assert (UI-state (display worriedQuestion_8)
                      (relation-asserted worry)
                      (valid-answers Yes No)))
)

(defrule  talk_back ""
    (logical (worry Yes))
    =>
    (assert (UI-state (display talkBackQuestion_10)
                      (relation-asserted talk_b)
                      (valid-answers Yes No)))
)

(defrule answer_wine  ""
    (logical (or
    (truth Yes)
    (talk_b No)
    (sleep No)
    (help Yes)
    (after No)
    (marmon No)
    (wasted No)
    ))
    =>
    (assert (UI-state (display wineAnswer)
                      (relation-asserted wine)
                      (state final)))
)

(defrule answer_non_alcoholic  ""
    (logical (or
    (talk_b Yes)
    (sleep Yes)
    (marmon Yes)
    ))
    =>
    (assert (UI-state (display nonAlcoholicAnswer)
                      (relation-asserted non_alcoholic)
                      (state final)))
)

(defrule asking_for_raise ""
    (logical (who_a No))
    =>
    (assert (UI-state (display raiseQestion_3)
                      (relation-asserted raise)
                      (valid-answers Yes No)))
)

(defrule office ""
    (logical (or
    (raise Yes)
    (promotion Yes)
    ))
    =>
    (assert (UI-state (display stopOffice)
                      (state final)))
)

(defrule asking_for_promotion ""
    (logical (raise No))
    =>
    (assert (UI-state (display promotionQuestion_5)
                      (relation-asserted promotion)
                      (valid-answers Yes No)))
)

(defrule seduce_boss ""
    (logical (promotion No))
    =>
    (assert (UI-state (display seduceQuestion_6)
                      (relation-asserted seduce)
                      (valid-answers Yes No)))
)

(defrule sleep_with_you ""
    (logical (or
    (seduce No)
    (worry No)
    ))
    =>
    (assert (UI-state (display sleepingQuestion_9)
                      (relation-asserted sleep)
                      (valid-answers Yes No)))
)

(defrule good_idea ""
    (logical (seduce Yes))
    =>
    (assert (UI-state (display sureQuestion_7)
                      (relation-asserted sure)
                      (valid-answers Yes No)))
)

(defrule answer_martini  ""
    (logical (or
    (after Yes)
    (sure No)
    (fired Yes)
    (cry Yes)
    (friday Yes)
    (longTime No)
    ))
    =>
    (assert (UI-state (display martiniAnswer)
                      (relation-asserted martini)
                      (state final)))
)

(defrule answer_fancy_cocktail  ""
    (logical (or
    (bigAccount No)
    (sure Yes)
    (cry No)
    (girls Yes)
    (keep No)
    (likePeople No)
    ))
    =>
    (assert (UI-state (display fancyCoctailAnswer)
                      (relation-asserted fancy_coctail)
                      (state final)))
)

(defrule why_q ""
    (logical (start_q startinganswer2))
    =>
    (assert (UI-state (display whyQuestion_11)
                      (relation-asserted why)
                      (valid-answers whyAnswer1 whyAnswer2 whyAnswer3)))
)

(defrule fired_q ""
    (logical (why whyAnswer1))
    =>
    (assert (UI-state (display firedQuestion_16)
                      (relation-asserted fired)
                      (valid-answers Yes No)))
)

(defrule scheming_for_promotion ""
    (logical (fired No))
    =>
    (assert (UI-state (display schemingQuestion_17)
                      (relation-asserted scheming)
                      (valid-answers Yes No)))
)

(defrule person_help ""
    (logical (scheming Yes))
    =>
    (assert (UI-state (display helpQuestion_18)
                      (relation-asserted help)
                      (valid-answers Yes No)))
)

(defrule bitchfest ""
    (logical (or
    (scheming No)
    (help No)
    ))
    =>
    (assert (UI-state (display morphQuestion_19)
                      (relation-asserted bitchfest)
                      (valid-answers Yes No)))
)

(defrule answer_highball  ""
    (logical (or
    (bitchfest No)
    (keep Yes)
    (major No)
    ))
    =>
    (assert (UI-state (display highballAnswer)
                      (relation-asserted highball)
                      (state final)))
)

(defrule answer_beer  ""
    (logical (or
    (bitchfest Yes)
    (workDrink No)
    (girls No)
    (writeOff No)
    ))
    =>
    (assert (UI-state (display beerAnswer)
                      (relation-asserted beer)
                      (state final)))
)

(defrule invite ""
    (logical (why whyAnswer2))
    =>
    (assert (UI-state (display inviteQuestion_12)
                      (relation-asserted invited)
                      (valid-answers Yes No)))
)

(defrule warning ""
    (logical (invited No))
    =>
    (assert (UI-state (display performanceQuestion_14)
                      (relation-asserted warned)
                      (valid-answers Yes No)))
)

(defrule answer_lowball  ""
    (logical (or
    (warned No)
    (male Yes)
    (writeOff Yes)
    ))
    =>
    (assert (UI-state (display lowballAnswer)
                      (relation-asserted lowball)
                      (state final)))
)

(defrule crier ""
    (logical (or
    (warned Yes)
    (truth No)
    ))
    =>
    (assert (UI-state (display crierQuestion_15)
                      (relation-asserted cry)
                      (valid-answers Yes No)))
)

(defrule handle_truth ""
    (logical (invited Yes))
    =>
    (assert (UI-state (display truthQuestion_13)
                      (relation-asserted truth)
                      (valid-answers Yes No)))
)

(defrule work_drink ""
    (logical (why whyAnswer3))
    =>
    (assert (UI-state (display workDrinksQuestion_20)
                      (relation-asserted workDrink)
                      (valid-answers Yes No)))
)

(defrule is_male ""
    (logical (workDrink Yes))
    =>
    (assert (UI-state (display maleQuestion_21)
                      (relation-asserted male)
                      (valid-answers Yes No)))
)

(defrule girls_night ""
    (logical (male No))
    =>
    (assert (UI-state (display girlsNightQuestion_22)
                      (relation-asserted girls)
                      (valid-answers Yes No)))
)

(defrule closing_deal ""
    (logical (start_q startinganswer4))
    =>
    (assert (UI-state (display closeQestion_23)
                      (relation-asserted closingDeal)
                      (valid-answers Yes No)))
)

(defrule big_account ""
    (logical (closingDeal Yes))
    =>
    (assert (UI-state (display expenseQuestion_24)
                      (relation-asserted bigAccount)
                      (valid-answers Yes No)))
)

(defrule dinner_after ""
    (logical (bigAccount Yes))
    =>
    (assert (UI-state (display afterQuestion_25)
                      (relation-asserted after)
                      (valid-answers Yes No)))
)

(defrule stay_under_radar ""
    (logical (or
    (closingDeal No)
    (likePerson No)
    ))
    =>
    (assert (UI-state (display schmoozingQuestion_26)
                      (relation-asserted schmoozing)
                      (valid-answers Yes No)))
)

(defrule big_drinker ""
    (logical (schmoozing Yes))
    =>
    (assert (UI-state (display drinkerQuestion_28)
                      (relation-asserted drinker)
                      (valid-answers Yes No)))
)

(defrule keep_up ""
    (logical (drinker Yes))
    =>
    (assert (UI-state (display obligatedQuestion_30)
                      (relation-asserted keep)
                      (valid-answers Yes No)))
)

(defrule they_marmon ""
    (logical (drinker No))
    =>
    (assert (UI-state (display marmonQuestion_29)
                      (relation-asserted marmon)
                      (valid-answers Yes No)))
)

(defrule have_life ""
    (logical (schmoozing No))
    =>
    (assert (UI-state (display lifeQuestion_27)
                      (relation-asserted life)
                      (valid-answers Yes No)))
)

(defrule not_honest ""
    (logical (life Yes))
    =>
    (assert (UI-state (display notHonest)
                      (relation-asserted life2)
                      (valid-answers Okay)))
)

(defrule no_life ""
    (logical (or
    (life2 Okay)
    (life No)
    ))
    =>
    (assert (UI-state (display stopLife)
                      (state final)))
)

(defrule official_function ""
    (logical (start_q startinganswer3))
    =>
    (assert (UI-state (display functionQuestion_31)
                      (relation-asserted official)
                      (valid-answers Yes No)))
)


(defrule like_people ""
    (logical (official No))
    =>
    (assert (UI-state (display likeGroupQuestion_32)
                      (relation-asserted likePeople)
                      (valid-answers Eh No)))
)

(defrule write_off ""
    (logical (likePeople Eh))
    =>
    (assert (UI-state (display writeOffQuestion_33)
                      (relation-asserted writeOff)
                      (valid-answers Yes No)))
)

(defrule it_is ""
    (logical (official Yes))
    =>
    (assert (UI-state (display itIsQuestion_34)
                      (relation-asserted itIs)
                      (valid-answers itIsanswer1 itIsanswer2 itIsanswer3)))
)

(defrule like_person ""
    (logical (itIs itIsanswer3))
    =>
    (assert (UI-state (display likePersonQuestion_35)
                      (relation-asserted likePerson)
                      (valid-answers Yes No)))
)

(defrule major_celebration ""
    (logical (itIs itIsanswer1))
    =>
    (assert (UI-state (display majorQuestion_36)
                      (relation-asserted major)
                      (valid-answers Yes No)))
)

(defrule get_wasted ""
    (logical (or
    (major Yes)
    (itIs itIsanswer2)
    ))
    =>
    (assert (UI-state (display wastedQuestion_37)
                      (relation-asserted wasted)
                      (valid-answers Yes No)))
)

(defrule friday_night ""
    (logical (wasted Yes))
    =>
    (assert (UI-state (display fridayQuestion_38)
                      (relation-asserted friday)
                      (valid-answers Yes No)))
)

(defrule working_long_time ""
    (logical (friday No))
    =>
    (assert (UI-state (display longTimeQuestion_39)
                      (relation-asserted longTime)
                      (valid-answers Yes No)))
)




(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
