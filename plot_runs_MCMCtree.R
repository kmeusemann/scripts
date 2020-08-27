# Authors:  Karen Meusemann & Lena Waidele, Evolutionary Biology & Ecology, Institute of Zoology, Biology I, University of Freiburg, Germany
#  Copyright (c) 2017-2020 Karen Meusemann & Lena Waidele
# All rights reserved.

# Redistribution and use in source with or without modification, are permitted provided
# that the following conditions are met:
# 1. Redistributions of the script must retain the above copyright notice, this list of conditions and the following disclaimer.
# in the documentation and/or other materials provided with the distribution.
# 2. All advertising materials mentioning features or any use of this software e.g. in publications must display the following acknowledgement:
# This script was developed by L. Waidele, and K. Meusemann, Evolutionary Biology & Ecology, Institute of Zoology, Biology I, University of Freiburg, Germany
# and provide in addition the link to the github repository.

# For questions, pls contact: Karen meusemann (mail@karen-meusemann.de)

# THIS SCRIPT IS PROVIDED BY K. MEUSEMANN ''AS IS'' AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHTHOLDER OR ITS ORGANISATION BE LIABLE FOR ANY
# DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# It is not allowed to use or redistribute the code of this script in projects which are
#  distributed under a license which is incompatible with above.


# This script will plot the comparison of two output chains of MCMCtree (PAML) of two runs
# coonsidering the posterior mean inferred divergence dates and the respective upper and lower CI values.

# posterior mean: pch=20 = circles
# lower CI: pch3: +
# upper CI: pch2: triangles

# PREPARATION:
# First, yo must modify the output of an MCMCtree run (of one chain) 
#and parse the respective section relevant for the plot into a 
# seperate file in csv format: 
# Usually this is part of our output file of MCMC tre. the section starts with:
# Posterior mean (95% Equal-tail CI) (95% HPD CI) HPD-CI-width
# In the following, for all splits in the tree 
# the post. mean and both CIs are listed like this:
# EXAMPLE:
# t_n67          4.0168 (3.7779, 4.1171) (3.8301, 4.1200) 0.2899 (Jnode 130)
# t_n68          3.6919 (3.2998, 3.9980) (3.3312, 4.0204) 0.6892 (Jnode 129)
# t_n69          1.6567 (1.2275, 2.2417) (1.1995, 2.2040) 1.0045 (Jnode 128)
# t_n70          3.8536 (3.5770, 4.0729) (3.6096, 4.0925) 0.4829 (Jnode 127)
# ...
# t_n131         2.5859 (2.1082, 2.9471) (2.1406, 2.9705) 0.8299 (Jnode 66)
# mu             0.0687 (0.0627, 0.0754) (0.0624, 0.0751) 0.0127
# sigma2         0.0819 (0.0577, 0.1155) (0.0551, 0.1114) 0.0563
# You only need the splits with the psot. mean values + both CIs (which are the first three columns.
# Use cat / head/ tail / awk, bash or sed to extract these lines and parse it into 
# a separate text file, emove the rounded brackets and convert into csv format:
# in the example it would look like this:
# t_n67,4.0168,3.7823,4.1170
# t_n68,3.6949,3.3048,4.0006
# t_n69,1.6633,1.2176,2.2527
# t_n70,3.8517,3.5777,4.0708
# t_n131,2.5808,2.1002,2.9425
# END OF FILE
# Proceed with all output files you want to compare (pairwise).
# save ths e.g. as run1_test.csv and run2_test.csv

################################################################################
# here the script starts to plot e.g. the PM, and oth CIs of two MCMCtree chains

#set working directory
setwd("~/home/")

#read in he two files
read.csv("run1_test.csv",sep=",",header=FALSE)->run1 
read.csv("run2_test.csv",sep=",",header=FALSE)->run2 


#set rownames of dataset 1
rownames(run1)<-run1[,1] 
#remove first column that still contains rownames
run1[,1]<-NULL 

#do the same for run2
rownames(run2)<-run2[,1]
run2[,1]<-NULL

#set header and generate name vector for that
header<-c("posterior_mean_age","CI_lower", "CI_upper")
colnames(run1)<-header
colnames(run2)<-header

#plot into a pdf file
pdf(file = "run1_vs_run2.pdf", width = 12, height = 9);
plot(run1$posterior_mean_age,run2$posterior_mean_age,pch=20,ylab = "run2", xlab = "run1")
abline(0, 1)
points(run1$CI_lower,run2$CI_lower,pch=3)
points(run1$CI_upper,run2$CI_upper,pch=2)
dev.off()

