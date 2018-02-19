# crewman-daniels
Build status: [![build status](https://travis-ci.org/rnowling/crewman-daniels.svg?branch=master)](https://travis-ci.org/rnowling/crewman-daniels)

[Crewman Daniels](http://memory-alpha.wikia.com/wiki/Daniels_(Crewman)) is a character from [Star Trek: Enterprise](https://en.wikipedia.org/wiki/Star_Trek:_Enterprise) who travels or transports the crew to various points in time to assist them.

<img src="https://vignette.wikia.nocookie.net/memoryalpha/images/8/89/Daniels2.jpg/revision/latest?cb=20100806165630&path-prefix=en" width="100px" height="120px">

Similary, `crewman-daniels` is a set of tools that help with analyzing the timeseries data generated by molecular dynamics simulations. Many of these tools build on excellent libraries maintained by others in the field.

## Dependencies

* [MDTraj](http://mdtraj.org)
* [Scikit-learn](http://scikit-learn.org/stable/)
* [MSMBuilder](http://msmbuilder.org)
* Numpy/Scipy/Matplotlib
* Seaborn

## Running Tests
To run the included tests, you will need to download the test data set (2 us of Ala5 simulation data).  The included `Makefile` can download the data and run the tests for you.

```bash
$ make test
```

Note that you will need to have the Git [Large File Storage](https://git-lfs.github.com/) plugin installed to download the data.  To run the tests, you will need to have [bats](https://github.com/sstephenson/bats) installed.
