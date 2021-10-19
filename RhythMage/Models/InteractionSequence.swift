//
//  InteractionSequence.swift
//  RhythMage
//
//  Created by Marcos Vinicius Majeveski De Angeli on 04/10/21.
//

import Foundation
import RealmSwift

/// The enum describing the type of sequence that will be displayed.
enum SequenceType: Int {
    case face = 0
    case tile = 1
}

/// The sequence of interactions that will compose a sequnce of the gameplay of the level.
class InteractionSequence {
    //MARK: Private Properties
    /// The duration of the sequence computated from each interaction duration.
    private var duration: Double{
        return calculateDuration()
    }
    
    //MARK: Public Properties
    /// The type describing the sequence.
    let type: SequenceType
    /// The sequence of interactions that will compose one part of the level.
    let sequence: [InteractionProtocol]
    
    
    //MARK: - Initialization
    init(type: SequenceType, sequence: [InteractionProtocol]){
        self.type = type
        self.sequence = sequence
    }
    
    //MARK: - Methods
    //TODO: Implementation
    /// Calculates the duration of the complete sequence based on the duration of each interaction.
    /// - Returns: The total duration of the sequence.
    func calculateDuration() -> Double{
        return 0
    }
}

//MARK: - Realm
class RealmInteractionSequence: Object {
    @objc dynamic let type: Int
    
    let sequence = List<RealmTileInteraction>()
    
    required init(){
        self.type = 0
    }
}

extension InteractionSequence {
    static func mockedInteraction() -> InteractionSequence {
        let data = [
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 1.1811433540424332,
              endTime: 1.297810022952035
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 1.7311433650320396,
              endTime: 1.8144767000339925
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 2.11447670601774,
              endTime: 2.1811433739494532
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 2.564476715051569,
              endTime: 2.6478100499371067
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 3.0144767239689827,
              endTime: 3.081143392017111
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 3.414476732024923,
              endTime: 3.4644767330028117
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 3.814476739964448,
              endTime: 3.9144767420366406
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 4.1644767470424995,
              endTime: 4.247810082044452
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 4.597810089006089,
              endTime: 4.681143424008042
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 4.9311434290139005,
              endTime: 4.997810096945614
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 5.347810104023665,
              endTime: 5.431143439025618
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 5.74781011196319,
              endTime: 5.797810112941079
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 6.14781012001913,
              endTime: 6.214476787950844
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 6.564476795028895,
              endTime: 6.614476796006784
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 6.96447680296842,
              endTime: 7.047810137970373
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 7.347810143954121,
              endTime: 7.414476812002249
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 7.731143484939821,
              endTime: 7.814476819941774
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 8.131143492995761,
              endTime: 8.231143494951539
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 8.547810168005526,
              endTime: 8.61447683593724
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 8.931143508991227,
              endTime: 8.997810177039355
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 9.39781018497888,
              endTime: 9.481143519980833
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 9.764476859010756,
              endTime: 9.864476860966533
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 10.18114353402052,
              endTime: 10.264476869022474
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 10.547810208052397,
              endTime: 10.631143542937934
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 10.931143549038097,
              endTime: 10.99781021696981
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 11.381143557955511,
              endTime: 11.464476892957464
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 11.714476897963323,
              endTime: 11.797810232965276
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 12.081143571995199,
              endTime: 12.164476906997152
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 12.497810247004963,
              endTime: 12.564476914936677
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 12.897810254944488,
              endTime: 12.981143589946441
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 13.264476928976364,
              endTime: 13.347810263978317
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 13.68114360398613,
              endTime: 13.764476938988082
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 14.031143610947765,
              endTime: 14.147810279973783
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 14.46447695302777,
              endTime: 14.547810288029723
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 14.84781029401347,
              endTime: 14.947810295969248
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 15.231143634999171,
              endTime: 15.314476970001124
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 15.66447697696276,
              endTime: 15.764476979034953
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 16.04781031794846,
              endTime: 16.147810320020653
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 16.514476993936114,
              endTime: 16.564476995030418
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 16.864477001014166,
              endTime: 16.94781033601612
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 17.247810341999866,
              endTime: 17.33114367700182
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 17.64781034993939,
              endTime: 17.731143684941344
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 18.081143692019396,
              endTime: 18.16447702702135
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 18.54781036800705,
              endTime: 18.647810369962826
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 18.93114370899275,
              endTime: 19.014477043994702
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 19.31447704997845,
              endTime: 19.414477052050643
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 19.71447705803439,
              endTime: 19.814477059990168
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 20.131143733044155,
              endTime: 20.214477068046108
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 20.547810407937504,
              endTime: 20.614477075985633
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 20.98114375001751,
              endTime: 21.031143750995398
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 21.36447709100321,
              endTime: 21.431143759051338
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 21.731143765035085,
              endTime: 21.7978104329668
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 22.13114377297461,
              endTime: 22.19781044102274
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 22.53114378103055,
              endTime: 22.614477116032504
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 22.89781045494601,
              endTime: 22.997810457018204
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 23.29781046300195,
              endTime: 23.381143798003905
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 23.664477137033828,
              endTime: 23.74781047203578
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 24.097810478997417,
              endTime: 24.18114381399937
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 24.464477153029293,
              endTime: 24.56447715498507
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 24.881143828039058,
              endTime: 24.94781049597077
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 25.297810503048822,
              endTime: 25.381143838050775
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 25.681143844034523,
              endTime: 25.747810511966236
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 26.114477185998112,
              endTime: 26.164477186976
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 26.531143861007877,
              endTime: 26.631143862963654
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 26.881143867969513,
              endTime: 26.964477202971466
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 27.331143877003342,
              endTime: 27.414477212005295
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 27.664477217011154,
              endTime: 27.76447721896693
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 28.131143892998807,
              endTime: 28.21447722800076
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 28.581143902032636,
              endTime: 28.64781056996435
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 28.914477242040448,
              endTime: 29.014477243996225
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 29.331143917050213,
              endTime: 29.414477252052166
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 29.731143924989738,
              endTime: 29.797810593037866
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 30.114477265975438,
              endTime: 30.181143934023567
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 30.49781060696114,
              endTime: 30.564477275009267
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 30.864477280993015,
              endTime: 30.947810615994968
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 31.314477290026844,
              endTime: 31.381143957958557
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 31.71447729796637,
              endTime: 31.781143966014497
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 32.09781063895207,
              endTime: 32.1644773070002
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 32.48114397993777,
              endTime: 32.5478106479859
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 32.897810654947534,
              endTime: 32.98114398994949
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 33.3144773299573,
              endTime: 33.41447733202949
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 33.71447733801324,
              endTime: 33.79781067301519
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 34.131144013023004,
              endTime: 34.19781068095472
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 34.497810686938465,
              endTime: 34.56447735498659
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 34.93114402901847,
              endTime: 34.99781069695018
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 35.31447737000417,
              endTime: 35.39781070500612
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 35.69781071098987,
              endTime: 35.79781071294565
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 36.114477385999635,
              endTime: 36.19781072100159
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 36.547810727963224,
              endTime: 36.63114406296518
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 36.931144068948925,
              endTime: 37.01447740395088
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 37.331144077004865,
              endTime: 37.36447741102893
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 37.69781075103674,
              endTime: 37.781144086038694
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 38.097810758976266,
              endTime: 38.21447742800228
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 38.481144099961966,
              endTime: 38.58114410203416
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 38.931144108995795,
              endTime: 39.03114411095157
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 39.331144117051736,
              endTime: 39.41447745193727
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 39.714477458037436,
              endTime: 39.78114412596915
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 40.0811441319529,
              endTime: 40.18114413402509
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 40.49781080696266,
              endTime: 40.597810809034854
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 40.914477481972426,
              endTime: 40.99781081697438
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 41.2811441560043,
              endTime: 41.364477491006255
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 41.66447749699,
              endTime: 41.747810831991956
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 42.11447750602383,
              endTime: 42.21447750797961
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 42.54781084798742,
              endTime: 42.61447751603555
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 42.93114418897312,
              endTime: 42.98114418995101
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 43.38114419800695,
              endTime: 44.16447754704859
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 44.49781088693999,
              endTime: 44.58114422194194
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 44.94781089597382,
              endTime: 45.014477564021945
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 45.34781090402976,
              endTime: 45.43114423903171
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 45.76447757903952,
              endTime: 46.36447759100702
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 46.69781093101483,
              endTime: 46.71447759796865
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 46.98114427004475,
              endTime: 47.064477605046704
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 47.381144277984276,
              endTime: 47.46447761298623
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 47.73114428494591,
              endTime: 47.814477619947866
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 48.13114429300185,
              endTime: 48.88114430801943
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 49.14781097997911,
              endTime: 49.21447764802724
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 49.44781098596286,
              endTime: 49.51447765401099
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 49.79781099304091,
              endTime: 49.864477660972625
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 50.16447766695637,
              endTime: 50.21447766805068
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 50.53114434098825,
              endTime: 50.9978110169759
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 51.16447768697981,
              endTime: 51.264477689052
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 51.49781102698762,
              endTime: 51.58114436198957
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 51.81447770004161,
              endTime: 51.89781103504356
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 52.19781104102731,
              endTime: 52.297811042983085
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 52.58114438201301,
              endTime: 52.64781104994472
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 52.96447772299871,
              endTime: 53.464477733010426
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 53.764477738994174,
              endTime: 53.8311444070423
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 54.164477747050114,
              endTime: 54.23114441498183
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 54.51447775401175,
              endTime: 54.61447775596753
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 54.89781109499745,
              endTime: 54.96447776304558
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 55.314477770007215,
              endTime: 55.564477775013074
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 55.79781111294869,
              endTime: 55.881144447950646
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 56.29781112296041,
              endTime: 56.381144457962364
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 56.66447779699229,
              endTime: 56.74781113199424
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 56.9978111370001,
              endTime: 57.06447780504823
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 57.364477811031975,
              endTime: 57.44781114603393
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 57.797811152995564,
              endTime: 58.24781116202939
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 58.64781116996892,
              endTime: 58.764477838994935
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 58.99781117704697,
              endTime: 59.04781117802486
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 59.347811184008606,
              endTime: 59.43114451901056
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 59.731144524994306,
              endTime: 59.81447785999626
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 60.11447786598001,
              endTime: 60.91447788197547
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 61.11447788600344,
              endTime: 61.197811221005395
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 61.431144558941014,
              endTime: 61.51447789394297
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 61.764477898948826,
              endTime: 61.831144566996954
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 62.11447790602688,
              endTime: 62.18114457395859
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 62.5144779139664,
              endTime: 63.364477930939756
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 63.581144602037966,
              endTime: 63.64781126996968
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 64.06447794497944,
              endTime: 64.16447794705164
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 64.51447795401327,
              endTime: 64.59781128901523
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 64.93114462902304,
              endTime: 65.91447798197623
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 66.24781132198405,
              endTime: 66.331144656986
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 66.61447799601592,
              endTime: 66.69781133101787
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 66.9811446700478,
              endTime: 67.06447800504975
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 67.38114467798732,
              endTime: 68.58114470203873
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 68.74781137204263,
              endTime: 68.83114470704459
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 69.09781137900427,
              endTime: 69.1644780470524
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 69.43114471901208,
              endTime: 69.53114472096786
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 69.79781139304396,
              endTime: 69.88114472804591
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 70.13114473305177,
              endTime: 70.23114473500755
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 70.5311447409913,
              endTime: 70.61447807599325
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 70.89781141502317,
              endTime: 70.98114475002512
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 71.2978114229627,
              endTime: 71.38114475796465
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 71.6811447639484,
              endTime: 71.76447809895035
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 72.06447810505051,
              endTime: 72.14781144005246
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 72.48114477994386,
              endTime: 72.56447811494581
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 72.84781145397574,
              endTime: 72.94781145604793
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 73.2644781289855,
              endTime: 73.33114479703363
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 73.66447813704144,
              endTime: 73.76447813899722
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 74.0811448120512,
              endTime: 74.18114481400698
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 74.5144781540148,
              endTime: 74.58114482194651
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 74.96447816304862,
              endTime: 75.04781149805058
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 75.33114483696409,
              endTime: 75.41447817196604
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 75.71447817794979,
              endTime: 75.79781151295174
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 76.0978115190519,
              endTime: 76.16447818698362
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 76.49781152699143,
              endTime: 76.58114486199338
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 2,
              startTime: 76.93114486895502,
              endTime: 77.01447820395697
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 1,
              startTime: 77.28114487603307,
              endTime: 77.36447821103502
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 0,
              startTime: 77.66447821701877,
              endTime: 77.74781155202072
            ),
            TileInteraction(minimumScore: 10,
              xPosition: 3,
              startTime: 78.19781156093813,
              endTime: 78.29781156301033
            )
          ]
        
        return InteractionSequence(type: SequenceType.tile, sequence: data)
    }
}
