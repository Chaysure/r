
R version 4.3.0 (2023-04-21) -- "Already Tomorrow"
Copyright (C) 2023 The R Foundation for Statistical Computing
Platform: aarch64-apple-darwin20 (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

  Natural language support but running in an English locale

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

[R.app GUI 1.79 (8225) aarch64-apple-darwin20]

[Workspace restored from /Users/chaitanyasure/.RData]
[History restored from /Users/chaitanyasure/.Rapp.history]

> mod_gbm <- train(classe~., data=train, method="gbm", trControl = control, tuneLength = 5, verbose = F)
Error in train(classe ~ ., data = train, method = "gbm", trControl = control,  : 
  could not find function "train"
> 
> traincsv <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
> testcsv <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")
> traincsv <- traincsv[,colMeans(is.na(traincsv)) < .9] #removing mostly na columns
> traincsv <- traincsv[,-c(1:7)] #removing metadata which is irrelevant to the outcome
> nvz <- nearZeroVar(traincsv)
Error in nearZeroVar(traincsv) : could not find function "nearZeroVar"
> traincsv <- traincsv[,-nvz]
> dim(traincsv)
[1] 19622    53
> inTrain <- createDataPartition(y=traincsv$classe, p=0.7, list=F)
Error in createDataPartition(y = traincsv$classe, p = 0.7, list = F) : 
  could not find function "createDataPartition"
> train <- traincsv[inTrain,]
> valid <- traincsv[-inTrain,]
> control <- trainControl(method="cv", number=3, verboseIter=F)
Error in trainControl(method = "cv", number = 3, verboseIter = F) : 
  could not find function "trainControl"
> library(lattice)
> library(ggplot2)
> library(caret)
> library(kernlab)

Attaching package: ‘kernlab’

The following object is masked from ‘package:ggplot2’:

    alpha

> library(rattle)
Loading required package: tibble
Loading required package: bitops
Rattle: A free graphical interface for data science with R.
Version 5.5.1 Copyright (c) 2006-2021 Togaware Pty Ltd.
Type 'rattle()' to shake, rattle, and roll your data.
> library(corrplot)
corrplot 0.92 loaded
> set.seed(1234)
> traincsv <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv")
> testcsv <- read.csv("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv")
> traincsv <- traincsv[,colMeans(is.na(traincsv)) < .9] #removing mostly na columns
> traincsv <- traincsv[,-c(1:7)] #removing metadata which is irrelevant to the outcome
> nvz <- nearZeroVar(traincsv)
> traincsv <- traincsv[,-nvz]
> dim(traincsv)
[1] 19622    53
> inTrain <- createDataPartition(y=traincsv$classe, p=0.7, list=F)
> train <- traincsv[inTrain,]
> valid <- traincsv[-inTrain,]
> control <- trainControl(method="cv", number=3, verboseIter=F)
> mod_trees <- train(classe~., data=train, method="rpart", trControl = control, tuneLength = 5)
> fancyRpartPlot(mod_trees$finalModel)
Warning message:
labs do not fit even at cex 0.15, there may be some overplotting 
> pred_trees <- predict(mod_trees, valid)
> cmtrees <- confusionMatrix(pred_trees, factor(valid$classe))
> cmtrees
Confusion Matrix and Statistics

          Reference
Prediction    A    B    C    D    E
         A 1519  473  484  451  156
         B   28  355   45   10  130
         C   83  117  423  131  131
         D   40  194   74  372  176
         E    4    0    0    0  489

Overall Statistics
                                          
               Accuracy : 0.5366          
                 95% CI : (0.5238, 0.5494)
    No Information Rate : 0.2845          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.3957          
                                          
 Mcnemar's Test P-Value : < 2.2e-16       

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            0.9074  0.31168  0.41228  0.38589  0.45194
Specificity            0.6286  0.95512  0.90492  0.90165  0.99917
Pos Pred Value         0.4927  0.62500  0.47797  0.43458  0.99189
Neg Pred Value         0.9447  0.85255  0.87940  0.88228  0.89002
Prevalence             0.2845  0.19354  0.17434  0.16381  0.18386
Detection Rate         0.2581  0.06032  0.07188  0.06321  0.08309
Detection Prevalence   0.5239  0.09652  0.15038  0.14545  0.08377
Balanced Accuracy      0.7680  0.63340  0.65860  0.64377  0.72555
> mod_gbm <- train(classe~., data=train, method="gbm", trControl = control, tuneLength = 5, verbose = F)
> 
> ls()
 [1] "a"           "beta0"       "beta1"       "cmtrees"     "coeftable"  
 [6] "control"     "diamond"     "e"           "father.son"  "fit"        
[11] "fit_mtcars"  "g"           "inTrain"     "mod_gbm"     "mod_trees"  
[16] "mtcars"      "n"           "nvz"         "pbeta"       "pbeta0"     
[21] "pbeta1"      "pred_trees"  "rho"         "sebeta0"     "sebeta1"    
[26] "sigma"       "ssc"         "step_mtcars" "tbeta0"      "tbeta1"     
[31] "testcsv"     "train"       "traincsv"    "valid"       "w"          
[36] "x"           "y"          
> pred_gbm <- predict(mod_gbm, valid)
> cmgbm <- confusionMatrix(pred_gbm, factor(valid$classe))
> cmgbm
Confusion Matrix and Statistics

          Reference
Prediction    A    B    C    D    E
         A 1671    8    0    0    0
         B    1 1122   14    0    0
         C    2    9 1009   10    4
         D    0    0    3  952    1
         E    0    0    0    2 1077

Overall Statistics
                                         
               Accuracy : 0.9908         
                 95% CI : (0.988, 0.9931)
    No Information Rate : 0.2845         
    P-Value [Acc > NIR] : < 2.2e-16      
                                         
                  Kappa : 0.9884         
                                         
 Mcnemar's Test P-Value : NA             

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            0.9982   0.9851   0.9834   0.9876   0.9954
Specificity            0.9981   0.9968   0.9949   0.9992   0.9996
Pos Pred Value         0.9952   0.9868   0.9758   0.9958   0.9981
Neg Pred Value         0.9993   0.9964   0.9965   0.9976   0.9990
Prevalence             0.2845   0.1935   0.1743   0.1638   0.1839
Detection Rate         0.2839   0.1907   0.1715   0.1618   0.1830
Detection Prevalence   0.2853   0.1932   0.1757   0.1624   0.1833
Balanced Accuracy      0.9982   0.9910   0.9891   0.9934   0.9975
> mod_svm <- train(classe~., data=train, method="svmLinear", trControl = control, tuneLength = 5, verbose = F)
> 
> pred_svm <- predict(mod_svm, valid)
> cmsvm <- confusionMatrix(pred_svm, factor(valid$classe))
> cmsvm
Confusion Matrix and Statistics

          Reference
Prediction    A    B    C    D    E
         A 1537  154   79   69   50
         B   29  806   90   46  152
         C   40   81  797  114   69
         D   61   22   32  697   50
         E    7   76   28   38  761

Overall Statistics
                                          
               Accuracy : 0.7813          
                 95% CI : (0.7705, 0.7918)
    No Information Rate : 0.2845          
    P-Value [Acc > NIR] : < 2.2e-16       
                                          
                  Kappa : 0.722           
                                          
 Mcnemar's Test P-Value : < 2.2e-16       

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            0.9182   0.7076   0.7768   0.7230   0.7033
Specificity            0.9164   0.9332   0.9374   0.9665   0.9690
Pos Pred Value         0.8137   0.7177   0.7239   0.8086   0.8363
Neg Pred Value         0.9657   0.9301   0.9521   0.9468   0.9355
Prevalence             0.2845   0.1935   0.1743   0.1638   0.1839
Detection Rate         0.2612   0.1370   0.1354   0.1184   0.1293
Detection Prevalence   0.3210   0.1908   0.1871   0.1465   0.1546
Balanced Accuracy      0.9173   0.8204   0.8571   0.8447   0.8362
> mod_rf <- train(classe~., data=train, method="rf", trControl = control, tuneLength = 5)

> 
> pred_rf <- predict(mod_rf, valid)
> cmrf <- confusionMatrix(pred_rf, factor(valid$classe))
> cmrf
Confusion Matrix and Statistics

          Reference
Prediction    A    B    C    D    E
         A 1673    3    0    0    0
         B    1 1132   10    0    0
         C    0    4 1014    5    1
         D    0    0    2  958    0
         E    0    0    0    1 1081

Overall Statistics
                                         
               Accuracy : 0.9954         
                 95% CI : (0.9933, 0.997)
    No Information Rate : 0.2845         
    P-Value [Acc > NIR] : < 2.2e-16      
                                         
                  Kappa : 0.9942         
                                         
 Mcnemar's Test P-Value : NA             

Statistics by Class:

                     Class: A Class: B Class: C Class: D Class: E
Sensitivity            0.9994   0.9939   0.9883   0.9938   0.9991
Specificity            0.9993   0.9977   0.9979   0.9996   0.9998
Pos Pred Value         0.9982   0.9904   0.9902   0.9979   0.9991
Neg Pred Value         0.9998   0.9985   0.9975   0.9988   0.9998
Prevalence             0.2845   0.1935   0.1743   0.1638   0.1839
Detection Rate         0.2843   0.1924   0.1723   0.1628   0.1837
Detection Prevalence   0.2848   0.1942   0.1740   0.1631   0.1839
Balanced Accuracy      0.9993   0.9958   0.9931   0.9967   0.9994
> 
> pred <- predict(mod_rf, testcsv)
> print(pred)
 [1] B A B A A E D B A A B C B A E E A B B B
Levels: A B C D E
> corrPlot <- cor(train[, -length(names(train))])
> corrplot(corrPlot, method="color")
> plot(mod_trees)
> plot(mod_gbm)
> 
> 