@extends('layouts.base-template')

@section('header')

    <header id="header" class="d-flex align-items-center bg-once fixed-top">
        <div class="container d-flex align-items-center justify-content-between">

            <div class="logo">
                <!-- <h1><a href="index.html"><span>Bootslander</span></a></h1> -->
                <!-- Uncomment below if you prefer to use an image logo -->
                <a href="/"><img src="/assets/icons/logo.png" alt="" class="img-fluid"></a>
            </div>

            <nav id="navbar" class="navbar">
                <ul>
                    <li><a class="nav-link scrollto" href="/documentation">DOCUMENTATION</a></li>
                    <li><a class="nav-link scrollto" href="/commercant">COMMERCANT</a></li>
                    <li><a class="nav-link scrollto" href="/particulier">PARTICULIER</a></li>
                    <li><a class="nav-link scrollto" href="/contact">CONTACT</a></li>
                    <li><a class="nav-link scrollto text-white" href="#gallery">connexion</a></li>
                    <li><a class="nav-link scrollto btn btn-sm btn-new-account-home mx-3 px-2 py-1 text-white" href="#gallery">creer un compte</a></li>
                </ul>
                <i class="bi bi-list mobile-nav-toggle"></i>
            </nav><!-- .navbar -->

        </div>
    </header>

@endsection

@section('hero')
    <section id="hero">
        <div class="container">
            <div class="row justify-content-between">
                <div class="col-lg-7 order-1 order-lg-2 hero-img aos-init " data-aos="zoom-out" data-aos-delay="200">
                    <div data-aos="zoom-out" class="aos-init aos-animate">
                        <h1>Build Your Landing Page With <span>Bootstlander</span></h1><br>
                        <h2>We are team of talented designers making websites with Bootstrap</h2><br>
                        <div class="text-center text-lg-start">
                            <a href="#about" style="z-index: 1" class="btn-get-started bg-white text-primary">En savoir
                                plus</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 pt-5 pt-lg-0 order-2 order-lg-1 d-flex align-items-center">
                    <img src="/assets/img/femme_acc.png" class="img-fluid animated" alt="">
                </div>
            </div>
            <!-- <br><br> -->
            <div class="row mb-4" id="zindex">
                <div class="col-md-3 p-3 shadow home-card bg-rgba text-white img-fluid animated">
                    <h4>+130</h4>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
                    eiusmod
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-3 p-3 bg-rgba shadow home-card text-white img-fluid animated">
                    <h4>+80</h4>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
                    eiusmod
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-3 p-3 shadow bg-rgba text-white home-card img-fluid animated">
                    <h4>+100</h4>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
                    eiusmod
                </div>
            </div>
        </div>
    </section>
@endsection


@section('main')
    <main id="main">

        <section id="features" class="features bg-features">
            <div class="container">
                <br>
                <br>
                <br>
                <br>
                <br>
                <div class="section-title" data-aos="fade-up">
                    <p class="text-dark">Reiciendis eveniet quod</p>
                </div>

                <div class="row" data-aos="fade-up">
                    <div class="col-md-6">
                        <div
                            class="row g-0 shadow border raduis-sm overflow-hidden flex-md-row mb-4 shadow h-md-150 position-relative">
                            <div class="col-auto d-none d-lg-block p-2">
                                <img class="bd-placeholder-img" width="120" height="150" src="/assets/img/details-1.png">

                            </div>
                            <div class="col p-4 d-flex flex-column position-static">
                                <h3 class="mb-0">Lorem ipsum</h3>
                                <p class="mb-auto">This is a wider card with supporting text below as a natural
                                    lead-in to additional content.</p>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div
                            class="row g-0 border raduis-sm overflow-hidden flex-md-row mb-4 shadow h-md-150 position-relative">
                            <div class=" p-2 col-auto d-none d-lg-block">
                                <img class="bd-placeholder-img" width="120" height="150" src="/assets/img/details-1.png">

                            </div>
                            <div class="col p-4 d-flex flex-column position-static">
                                <h3 class="mb-0">Lorem ipsum</h3>
                                <p class="mb-auto">This is a wider card with supporting text below as a natural
                                    lead-in to additional content.</p>
                            </div>

                        </div>
                    </div>
                </div>
                <br>
                <br>
                <br>
                <div class="row mt-3" data-aos="fade-up">
                    <div class="col-md-6">
                        <div
                            class="row g-0 shadow border raduis-sm overflow-hidden flex-md-row mb-4 shadow h-md-150 position-relative">
                            <div class="col-auto d-none d-lg-block p-2">
                                <img class="bd-placeholder-img" width="120" height="150" src="/assets/img/details-1.png">

                            </div>
                            <div class="col p-4 d-flex flex-column position-static">
                                <h3 class="mb-0">Lorem ipsum</h3>
                                <p class="mb-auto">This is a wider card with supporting text below as a natural
                                    lead-in to additional content.</p>
                            </div>

                        </div>
                    </div>
                    <div class="col-md-6">
                        <div
                            class="row g-0 border raduis-sm overflow-hidden flex-md-row mb-4 shadow h-md-150 position-relative">
                            <div class=" p-2 col-auto d-none d-lg-block">
                                <img class="bd-placeholder-img" width="120" height="150" src="/assets/img/details-1.png">

                            </div>
                            <div class="col p-4 d-flex flex-column position-static">
                                <h3 class="mb-0">Lorem ipsum</h3>
                                <p class="mb-auto">This is a wider card with supporting text below as a natural
                                    lead-in to additional content.</p>
                            </div>

                        </div>
                    </div>
                </div>
                <br>
                <br>
                <br>
                <br>
                <br>
                <div class="row">
                    <div class="col-xl-5 col-lg-6 video-box d-flex justify-content-center align-items-stretch"
                        data-aos="fade-right">
                        <img src="/assets/img/Account-rafiki.png" alt="DETAIL 2" class="detail-img">
                    </div>

                    <div class="col-xl-7 col-lg-6 icon-boxes d-flex flex-column align-items-stretch justify-content-center py-5 px-lg-5"
                        data-aos="fade-left">
                        <h4>Esse voluptas cumque vel exercitationem. Reiciendis est hic accusamus. Non ipsam et sed minima
                            temporibus laudantium. Soluta voluptate sed facere corporis dolores excepturi. Libero laboriosam
                            sint et id nulla tenetur. Suscipit aut voluptate.</h4>
                        <button class="btn btn-outline-primary shadow my-3" type="button">En savoir plus</button>
                    </div>
                </div>

            </div>
        </section><!-- End Features Section -->
        <section id="about" class="about">
            <div class="container my-3">
                <div class="card card-body green-color shadow raduis-sm" data-aos="fade-up">
                    <div class="text-center icon-boxes d-flex flex-column px-5 justify-content-center py-3">
                        <h3 class=" text-tranche text-white">Enim quis est voluptatibus</h3>
                        <p style="margin: auto; width: 70%" class="text-white">Esse voluptas cumque vel exercitationem.
                            Reiciendis est hic
                            accusamus. Non ipsam et sed minima
                            temporibus laudantium. Soluta voluptate sed.</p>
                        <button class="btn-jum my-2 btn btn-sm shadow bg-white p-2">INSTALLER L'API</button>
                    </div>
                </div>
            </div>
        </section>


        <!-- ======= Details Section ======= -->
        <section id="details" class="details">
            <div class="container">
                <div class="row content">
                    <div class="col-md-4 mx-4 order-1 order-md-2" data-aos="fade-left">
                        <img src="assets/img/details-4.png" class="img-fluid" alt="" height="200" width="200">
                    </div>
                    <div class="col-md-7 pt-5 order-2 order-md-1" data-aos="fade-up">
                        <h3>Quas et necessitatibus eaque impedit</h3>
                        <p>
                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Quo perferendis accusamus qui maxime
                            aperiam officiis sapiente quisquam fugiat eveniet omnis nostrum ipsa blanditiis, quod vitae
                            dolores odio nihil molestias ducimus.
                        </p>
                        <a href="/particulier" class="btn bg-dark-green">EN SAVOIR PLUS</a>
                    </div>
                </div>
                <div class="row content">
                    <div class="col-md-4" data-aos="fade-right">
                        <img src="assets/img/details-3.png" class="img-fluid" alt="" width="200" height="200">
                    </div>
                    <div class="col-md-7 pt-5" data-aos="fade-up">
                        <h3>Sunt consequatur ad ut est nulla consectetur</h3>
                        <p>
                            Lorem ipsum dolor sit amet consectetur adipisicing elit. Laborum, iure. Eaque quod delectus
                            odio, ipsa laborum temporibus earum sed sunt fugiat quam ratione, quos error ducimus deleniti
                            necessitatibus corrupti at!
                        </p>
                        <a href="/commercant" class="btn bg-dark-green">EN SAVOIR PLUS</a>
                    </div>
                </div>
            </div>

            <br>
            <br>
            <br>


        </section><!-- End Details Section -->
    </main><!-- End #main -->


@endsection

@section('footer')
    <footer class="bg-gray my-3">
        <div class="grid-container ">
            <div class="container-fluid home-footer">
                <div class="px-5">
                    <p class="h3 text-white">
                        Lorem ipsum dolor sit amet consectetur adipisicing elit. <br> Quis deserunt quisquam soluta mollitia
                        sapiente eius id vero <br> fugiat earum temporibus minus nesciunt <br> sunt voluptatibus hic
                        dignissimos optio, at ad dolores!
                    </p>
                    <button class="btn-1 my-4 btn shadow">CONNEXION</button>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="row py-5 ">
                <div class="col-md-4 ">
                    <div class="my-5">
                        <a href="/">
                            <img src="/assets/img/logo.jpeg" alt="LOGO" width="100"></a>
                    </div>
                    <span class="text-muted">
                        Lorem ipsum dolor sit amet consectetur, Temporibus earum necessitatibus itaque.
                    </span>
                    <div>
                        <div class="row">
                            <div class="col-md-2 mx-1 circle-icon">
                                <i class="fa fa-facebook" aria-hidden="false"></i>
                            </div>
                            <div class="col-md-2 mx-1 circle-icon">
                                <i class="fa fa-twitch" aria-hidden="false"></i>
                            </div>
                            <div class="col-md-2 mx-1 circle-icon">
                                <i class="fa fa-linkedin" aria-hidden="true"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <span class="text-dark">
                        Retrouver nous sur les plateformes
                    </span> <br>
                    <div>
                        <div class="row container d-flex justify-content-center">
                            <div class="template-demo mt-2"> <button class="btn btn-outline-dark btn-icon-text"> <i
                                        class="fa fa-apple btn-icon-prepend mdi-36px"></i> <span
                                        class="d-inline-block text-left"> <small
                                            class="font-weight-light d-block">Available
                                            on the</small> App Store </span> </button> <button
                                    class="btn btn-outline-dark btn-icon-text"> <i
                                        class="fa fa-android btn-icon-prepend mdi-36px"></i> <span
                                        class="d-inline-block text-left"> <small class="font-weight-light d-block">Get it
                                            on the</small> Google Play </span> </button> </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="row">
                        <div class="col-md-6">
                            <ul class="list-service">
                                <strong>Services</strong>
                                <li>Service 1</li>
                                <li>Service 2</li>
                                <li>Service 3</li>
                                <li>Service 4</li>
                            </ul>
                        </div>
                        <div class="col-md-6">
                            <ul class="list-service">
                                <strong>Services</strong>
                                <li>Service 1</li>
                                <li>Service 2</li>
                                <li>Service 3</li>
                                <li>Service 4</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
@endsection
