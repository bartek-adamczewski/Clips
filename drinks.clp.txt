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
    (talk_b No)
    (sleep No)
    (help Yes)
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
    (logical (seduce No))
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
    (sure No)
    (fired Yes)
    ))
    =>
    (assert (UI-state (display martiniAnswer)
                      (relation-asserted martini)
                      (state final)))
)

(defrule answer_fancy_cocktail  ""
    (logical (or
    (sure Yes)
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
                      (valid-answers whyAsnwer1 whyAsnwer2 whyAsnwer3)))
)

(defrule fired_q ""
    (logical (why whyAsnwer1))
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
    ))
    =>
    (assert (UI-state (display highballAnswer)
                      (relation-asserted highball)
                      (state final)))
)

(defrule answer_beer  ""
    (logical (or
    (bitchfest Yes)
    ))
    =>
    (assert (UI-state (display beerAnswer)
                      (relation-asserted beer)
                      (state final)))
)